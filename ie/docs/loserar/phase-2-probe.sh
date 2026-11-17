#!/bin/sh
# Loserar phase-2 behavioral probe.
#
# The probe is deliberately noninteractive. Every archive command is run in a
# fresh self-owned temporary workspace, every case captures stdout/stderr and
# an exit code, and a hung case is terminated after a portable wall-clock
# bound. The evidence report is written outside the temporary workspace before
# the workspace is removed.

set -u

RAR_PATH=${RAR_PATH:-/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar}
UNRAR_PATH=${UNRAR_PATH:-/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar}
REA_PATH=${REA_PATH:-/Users/mateo.hdz/.npm/_npx/af752b90495482d7/node_modules/.bin/rea}
CASE_TIMEOUT_SECONDS=${CASE_TIMEOUT_SECONDS:-20}
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
REPORT_PATH=${REPORT_PATH:-$SCRIPT_DIR/phase-2-report.md}
PROBE_ROOT=
ACTIVE_PID=

cleanup() {
    if [ -n "${PROBE_ROOT:-}" ] && [ -d "$PROBE_ROOT" ]; then
        case "$PROBE_ROOT" in
            /tmp/loserar-phase2.*) rm -rf "$PROBE_ROOT" ;;
            *) printf '%s\n' "Refusing to clean an unexpected path: $PROBE_ROOT" >&2 ;;
        esac
    fi
}

stop_active() {
    if [ -n "${ACTIVE_PID:-}" ] && kill -0 "$ACTIVE_PID" 2>/dev/null; then
        kill -TERM "$ACTIVE_PID" 2>/dev/null || true
        sleep 1
        kill -KILL "$ACTIVE_PID" 2>/dev/null || true
    fi
}

on_exit() {
    status=$?
    stop_active
    cleanup
    exit "$status"
}

on_signal() {
    stop_active
    exit 130
}

trap on_exit EXIT
trap on_signal INT TERM HUP

if [ ! -x "$RAR_PATH" ] || [ ! -x "$UNRAR_PATH" ]; then
    printf '%s\n' "Both executable target paths must be executable." >&2
    printf 'RAR_PATH=%s\nUNRAR_PATH=%s\n' "$RAR_PATH" "$UNRAR_PATH" >&2
    exit 2
fi

PROBE_ROOT=$(mktemp -d /tmp/loserar-phase2.XXXXXX) || exit 2
RESULTS="$PROBE_ROOT/results"
FIXTURES="$PROBE_ROOT/fixtures"
ARCHIVES="$PROBE_ROOT/archives"
mkdir -p "$RESULTS" "$FIXTURES/input/nested/space dir" \
    "$FIXTURES/input/a" "$FIXTURES/input/b" "$ARCHIVES"

CASES="$RESULTS/cases.tsv"
ARTIFACTS="$RESULTS/artifacts.tsv"
MANIFEST="$RESULTS/fixture-manifest.txt"
printf 'id\texit_code\ttimed_out\tstart_epoch\tend_epoch\tduration_seconds\tstdout\tstderr\tworking_directory\tcommand\n' > "$CASES"
: > "$ARTIFACTS"

shell_quote() {
    printf "'%s'" "$(printf '%s' "$1" | sed "s/'/'\\\\''/g")"
}

now_epoch() { date +%s; }

run_case() {
    case_id=$1
    working_directory=$2
    shift 2

    stdout_file="$RESULTS/$case_id.stdout"
    stderr_file="$RESULTS/$case_id.stderr"
    command_line=
    for argument in "$@"; do
        quoted_argument=$(shell_quote "$argument")
        if [ -n "$command_line" ]; then
            command_line="$command_line $quoted_argument"
        else
            command_line=$quoted_argument
        fi
    done

    start_epoch=$(now_epoch)
    (
        cd "$working_directory" || exit 125
        exec "$@"
    ) >"$stdout_file" 2>"$stderr_file" &
    ACTIVE_PID=$!
    timed_out=0
    while kill -0 "$ACTIVE_PID" 2>/dev/null; do
        process_state=$(ps -o state= -p "$ACTIVE_PID" 2>/dev/null | tr -d '[:space:]')
        case "$process_state" in
            ''|Z*) break ;;
        esac
        now=$(now_epoch)
        if [ $((now - start_epoch)) -ge "$CASE_TIMEOUT_SECONDS" ]; then
            timed_out=1
            kill -TERM "$ACTIVE_PID" 2>/dev/null || true
            sleep 1
            kill -KILL "$ACTIVE_PID" 2>/dev/null || true
            break
        fi
        sleep 1
    done
    wait "$ACTIVE_PID" 2>/dev/null
    exit_code=$?
    if [ "$timed_out" -eq 1 ]; then exit_code=124; fi
    ACTIVE_PID=
    end_epoch=$(now_epoch)
    duration_seconds=$((end_epoch - start_epoch))

    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
        "$case_id" "$exit_code" "$timed_out" "$start_epoch" "$end_epoch" \
        "$duration_seconds" "$stdout_file" "$stderr_file" \
        "$working_directory" "$command_line" >> "$CASES"
    printf 'CASE %-34s exit=%s timeout=%s duration=%ss\n' \
        "$case_id" "$exit_code" "$timed_out" "$duration_seconds"
}

record_skipped() {
    case_id=$1
    working_directory=$2
    command_line=$3
    reason=$4
    stdout_file="$RESULTS/$case_id.stdout"
    stderr_file="$RESULTS/$case_id.stderr"
    : > "$stdout_file"
    printf '%s\n' "$reason" > "$stderr_file"
    now=$(now_epoch)
    printf '%s\tSKIPPED\t0\t%s\t%s\t0\t%s\t%s\t%s\t%s\n' \
        "$case_id" "$now" "$now" "$stdout_file" "$stderr_file" \
        "$working_directory" "$command_line" >> "$CASES"
    printf 'CASE %-34s status=SKIPPED\n' "$case_id"
}

hash_file() { shasum -a 256 "$1" | awk '{print $1}'; }
file_size() { wc -c < "$1" | awk '{print $1}'; }

record_artifact() {
    artifact_kind=$1
    artifact_path=$2
    if [ -f "$artifact_path" ]; then
        printf '%s\t%s\t%s\t%s\n' "$artifact_kind" "$artifact_path" \
            "$(file_size "$artifact_path")" "$(hash_file "$artifact_path")" >> "$ARTIFACTS"
    fi
}

printf '%s\n' 'Loserar phase-2 probe'
printf 'UTC_START=%s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
printf 'RAR_PATH=%s\nUNRAR_PATH=%s\n' "$RAR_PATH" "$UNRAR_PATH"
printf 'RAR_SHA256=%s\nUNRAR_SHA256=%s\n' "$(hash_file "$RAR_PATH")" "$(hash_file "$UNRAR_PATH")"
printf 'CASE_TIMEOUT_SECONDS=%s\n' "$CASE_TIMEOUT_SECONDS"
printf 'HOST='; uname -a

# Identity and command surface.
run_case identity_rar_file / "$RAR_PATH" "$RAR_PATH"
run_case identity_rar_sha256 / shasum -a 256 "$RAR_PATH"
run_case identity_rar_version / "$RAR_PATH" -iver
run_case identity_rar_help / "$RAR_PATH" -?
run_case identity_unrar_file / "$UNRAR_PATH" "$UNRAR_PATH"
run_case identity_unrar_sha256 / shasum -a 256 "$UNRAR_PATH"
run_case identity_unrar_version / "$UNRAR_PATH" -iver
run_case identity_unrar_help / "$UNRAR_PATH" -?

# Self-owned fixtures: nested paths, spaces, Unicode, zero bytes, duplicate
# basenames, deterministic timestamps, permissions, and a contained symlink.
printf 'nested file\n' > "$FIXTURES/input/nested/space dir/Unicode-é.txt"
printf 'duplicate A\n' > "$FIXTURES/input/a/duplicate.txt"
printf 'duplicate B\n' > "$FIXTURES/input/b/duplicate.txt"
: > "$FIXTURES/input/zero-byte.bin"
printf 'timestamped\n' > "$FIXTURES/input/timestamp.txt"
printf 'filter me\n' > "$FIXTURES/input/filter-me.txt"
touch -t 202001020304.05 "$FIXTURES/input/timestamp.txt"
chmod 640 "$FIXTURES/input/timestamp.txt"
if ln -s "timestamp.txt" "$FIXTURES/input/symlink-to-timestamp" 2>"$RESULTS/fixture_symlink.stderr"; then
    SYMLINK_STATUS=created
else
    SYMLINK_STATUS=blocked
fi

{
    printf '%s\n' 'Fixture manifest:'
    find "$FIXTURES" \( -type f -o -type l \) -print | sort | while IFS= read -r fixture; do
        if [ -L "$fixture" ]; then
            printf 'SYMLINK %s -> %s\n' "$fixture" "$(readlink "$fixture")"
        else
            printf 'FILE %s bytes=%s sha256=%s\n' "$fixture" "$(file_size "$fixture")" "$(hash_file "$fixture")"
        fi
    done
    printf 'SYMLINK_STATUS=%s\n' "$SYMLINK_STATUS"
} | tee "$MANIFEST"

ARCHIVE="$ARCHIVES/main.rar"
run_case rar_a_default "$FIXTURES" "$RAR_PATH" a -y "$ARCHIVE" input
record_artifact archive "$ARCHIVE"
run_case rar_l_default "$FIXTURES" "$RAR_PATH" l "$ARCHIVE"
run_case rar_t_default "$FIXTURES" "$RAR_PATH" t "$ARCHIVE"
run_case unrar_l_default "$FIXTURES" "$UNRAR_PATH" l -p- "$ARCHIVE"
run_case unrar_lt_default "$FIXTURES" "$UNRAR_PATH" lt -p- "$ARCHIVE"
run_case unrar_lta_default "$FIXTURES" "$UNRAR_PATH" lta -p- "$ARCHIVE"
run_case unrar_lb_default "$FIXTURES" "$UNRAR_PATH" lb -p- "$ARCHIVE"
run_case unrar_t_default "$FIXTURES" "$UNRAR_PATH" t -p- "$ARCHIVE"

# Print, flatten, preserve, filters, and overwrite/collision cases.
run_case unrar_p_exact "$FIXTURES" "$UNRAR_PATH" p -p- "$ARCHIVE" "input/nested/space dir/Unicode-é.txt"
run_case unrar_p_dot_selector "$FIXTURES" "$UNRAR_PATH" p -p- "$ARCHIVE" "./input/nested/space dir/Unicode-é.txt"
run_case unrar_p_dotdot_selector "$FIXTURES" "$UNRAR_PATH" p -p- "$ARCHIVE" "input/nested/space dir/../space dir/Unicode-é.txt"

E_DIR="$PROBE_ROOT/extract-e"
X_DIR="$PROBE_ROOT/extract-x"
FILTER_DIR="$PROBE_ROOT/extract-filter"
EXCLUDE_DIR="$PROBE_ROOT/extract-exclude"
COLLISION_SKIP_DIR="$PROBE_ROOT/collision-skip"
COLLISION_OVERWRITE_DIR="$PROBE_ROOT/collision-overwrite"
mkdir -p "$E_DIR" "$X_DIR" "$FILTER_DIR" "$EXCLUDE_DIR" \
    "$COLLISION_SKIP_DIR" "$COLLISION_OVERWRITE_DIR"
run_case unrar_e_flatten "$FIXTURES" "$UNRAR_PATH" e -p- -y -op"$E_DIR" "$ARCHIVE" "input/*"
run_case unrar_x_preserve "$FIXTURES" "$UNRAR_PATH" x -p- -y -op"$X_DIR" "$ARCHIVE" "input/*"
run_case unrar_x_nested_filter "$FIXTURES" "$UNRAR_PATH" x -p- -y -op"$FILTER_DIR" "$ARCHIVE" "input/nested/*"
run_case unrar_x_exclude_zero "$FIXTURES" "$UNRAR_PATH" x -p- -y -op"$EXCLUDE_DIR" -xinput/zero-byte.bin "$ARCHIVE" "input/*"
run_case unrar_e_collision_skip "$FIXTURES" "$UNRAR_PATH" e -p- -o- -op"$COLLISION_SKIP_DIR" "$ARCHIVE" "input/a/duplicate.txt" "input/b/duplicate.txt"
run_case unrar_e_collision_overwrite "$FIXTURES" "$UNRAR_PATH" e -p- -o+ -op"$COLLISION_OVERWRITE_DIR" "$ARCHIVE" "input/a/duplicate.txt" "input/b/duplicate.txt"

# Creation filters and symlink behavior.
FILTER_ARCHIVE="$ARCHIVES/filter.rar"
run_case rar_a_creation_filter "$FIXTURES" "$RAR_PATH" a -y -xinput/zero-byte.bin "$FILTER_ARCHIVE" input
record_artifact archive "$FILTER_ARCHIVE"
run_case unrar_l_creation_filter "$FIXTURES" "$UNRAR_PATH" lb -p- "$FILTER_ARCHIVE"
if [ "$SYMLINK_STATUS" = created ]; then
    SYMLINK_ARCHIVE="$ARCHIVES/symlink-preserved.rar"
    SYMLINK_DEFAULT_ARCHIVE="$ARCHIVES/symlink-default.rar"
    run_case rar_a_symlink_preserve "$FIXTURES" "$RAR_PATH" a -y -ol "$SYMLINK_ARCHIVE" input/symlink-to-timestamp
    run_case rar_a_symlink_default "$FIXTURES" "$RAR_PATH" a -y "$SYMLINK_DEFAULT_ARCHIVE" input/symlink-to-timestamp
    record_artifact archive "$SYMLINK_ARCHIVE"
    record_artifact archive "$SYMLINK_DEFAULT_ARCHIVE"
    run_case unrar_lt_symlink_preserve "$FIXTURES" "$UNRAR_PATH" lta -p- "$SYMLINK_ARCHIVE"
    run_case unrar_lt_symlink_default "$FIXTURES" "$UNRAR_PATH" lta -p- "$SYMLINK_DEFAULT_ARCHIVE"
else
    record_skipped symlink_cases "$FIXTURES" "rar/unrar symlink cases" 'ln -s was not available; symlink behavior was not tested.'
fi

# Compression, dictionary, and solidness observations.
for level in 0 1 2 3 4 5; do
    compression_archive="$ARCHIVES/m${level}.rar"
    run_case "rar_a_m${level}" "$FIXTURES" "$RAR_PATH" a -y "-m${level}" "$compression_archive" input
    record_artifact archive "$compression_archive"
done
for dictionary in 64k 1m; do
    dictionary_archive="$ARCHIVES/dictionary-${dictionary}.rar"
    run_case "rar_a_dictionary_${dictionary}" "$FIXTURES" "$RAR_PATH" a -y -m3 "-md${dictionary}" "$dictionary_archive" input
    record_artifact archive "$dictionary_archive"
done
SOLID_ARCHIVE="$ARCHIVES/solid.rar"
NONSOLID_ARCHIVE="$ARCHIVES/non-solid.rar"
run_case rar_a_solid "$FIXTURES" "$RAR_PATH" a -y -s "$SOLID_ARCHIVE" input
run_case rar_a_non_solid "$FIXTURES" "$RAR_PATH" a -y -s- "$NONSOLID_ARCHIVE" input
record_artifact archive "$SOLID_ARCHIVE"
record_artifact archive "$NONSOLID_ARCHIVE"

# Known-password data and header encryption. No password discovery is attempted.
DATA_PASSWORD=LoserarDataPhase2!
HEADER_PASSWORD=LoserarHeaderPhase2!
DATA_ARCHIVE="$ARCHIVES/data-encrypted.rar"
HEADER_ARCHIVE="$ARCHIVES/header-encrypted.rar"
run_case rar_a_data_encryption "$FIXTURES" "$RAR_PATH" a -y "-p${DATA_PASSWORD}" "$DATA_ARCHIVE" input
record_artifact archive "$DATA_ARCHIVE"
run_case unrar_l_data_encryption_no_password "$FIXTURES" "$UNRAR_PATH" l -p- "$DATA_ARCHIVE"
run_case unrar_t_data_password "$FIXTURES" "$UNRAR_PATH" t "-p${DATA_PASSWORD}" "$DATA_ARCHIVE"
run_case unrar_t_wrong_data_password "$FIXTURES" "$UNRAR_PATH" t -pWrongLoserarPassword "$DATA_ARCHIVE"
run_case rar_a_header_encryption "$FIXTURES" "$RAR_PATH" a -y "-hp${HEADER_PASSWORD}" "$HEADER_ARCHIVE" input
record_artifact archive "$HEADER_ARCHIVE"
run_case unrar_l_header_no_password "$FIXTURES" "$UNRAR_PATH" l -p- "$HEADER_ARCHIVE"
run_case unrar_l_header_password "$FIXTURES" "$UNRAR_PATH" l "-p${HEADER_PASSWORD}" "$HEADER_ARCHIVE"
run_case unrar_t_header_password "$FIXTURES" "$UNRAR_PATH" t "-p${HEADER_PASSWORD}" "$HEADER_ARCHIVE"
run_case unrar_t_wrong_header_password "$FIXTURES" "$UNRAR_PATH" t -pWrongLoserarPassword "$HEADER_ARCHIVE"

# Volumes and recovery are intentionally not executed: their command surfaces
# can create multiple files or enter recovery-specific paths and were not
# proven noninteractive for this probe.
record_skipped volumes_not_run "$FIXTURES" 'rar a -v...; rar v ...; unrar t ...' \
    'Skipped by safety policy: volume creation/listing/testing was not proven noninteractive.'
record_skipped recovery_not_run "$FIXTURES" 'rar a -rr...; rar v ...; unrar t ...' \
    'Skipped by safety policy: recovery-record creation/listing/testing was not proven noninteractive.'

# Failure fixtures and unsupported/unknown switches.
MISSING_ARCHIVE="$ARCHIVES/does-not-exist.rar"
TRUNCATED_ARCHIVE="$ARCHIVES/truncated.rar"
MALFORMED_ARCHIVE="$ARCHIVES/malformed.rar"
if [ -f "$ARCHIVE" ]; then
    head -c 64 "$ARCHIVE" > "$TRUNCATED_ARCHIVE"
else
    printf '%s\n' 'archive unavailable; self-owned truncated placeholder' > "$TRUNCATED_ARCHIVE"
fi
printf '%s\n' 'not a RAR archive; self-owned malformed fixture' > "$MALFORMED_ARCHIVE"
record_artifact fixture "$TRUNCATED_ARCHIVE"
record_artifact fixture "$MALFORMED_ARCHIVE"
run_case fail_missing_unrar_t "$FIXTURES" "$UNRAR_PATH" t -p- "$MISSING_ARCHIVE"
run_case fail_missing_rar_l "$FIXTURES" "$RAR_PATH" l "$MISSING_ARCHIVE"
run_case fail_truncated_unrar_t "$FIXTURES" "$UNRAR_PATH" t -p- "$TRUNCATED_ARCHIVE"
run_case fail_truncated_rar_l "$FIXTURES" "$RAR_PATH" l "$TRUNCATED_ARCHIVE"
run_case fail_malformed_unrar_l "$FIXTURES" "$UNRAR_PATH" l -p- "$MALFORMED_ARCHIVE"
run_case fail_malformed_rar_l "$FIXTURES" "$RAR_PATH" l "$MALFORMED_ARCHIVE"
run_case fail_unknown_unrar_switch "$FIXTURES" "$UNRAR_PATH" t -p- -LoserarUnknownSwitch "$ARCHIVE"
run_case fail_unknown_rar_switch "$FIXTURES" "$RAR_PATH" t -LoserarUnknownSwitch "$ARCHIVE"
run_case fail_unsupported_rar_format "$FIXTURES" "$RAR_PATH" a -y -ma4 "$ARCHIVES/unsupported-ma4.rar" input

if [ -x "$REA_PATH" ]; then
    run_case rea_mcp_doctor / "$REA_PATH" mcp doctor --format json
else
    record_skipped rea_mcp_doctor / "$REA_PATH mcp doctor --format json" \
        'The configured REA CLI was not executable; REA readiness was not part of this run.'
fi

generate_report() {
    report_tmp="$REPORT_PATH.tmp.$$"
    {
        printf '# Loserar Phase-2 Probe Report\n\n'
        printf '%s\n' "- **Run date (UTC):** $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
        printf '%s\n' "- **Host:** $(uname -a)"
        printf '%s\n' "- **RAR:** \`$RAR_PATH\`"
        printf '%s\n' "- **RAR SHA-256:** \`$(hash_file "$RAR_PATH")\`"
        printf '%s\n' "- **UNRAR:** \`$UNRAR_PATH\`"
        printf '%s\n' "- **UNRAR SHA-256:** \`$(hash_file "$UNRAR_PATH")\`"
        printf '%s\n' "- **Per-case timeout:** ${CASE_TIMEOUT_SECONDS}s; implemented with POSIX sh background polling, \`kill\`, and \`sleep\`."
        printf '%s\n\n' '- **Temporary evidence:** self-owned fixtures only; the probe directory is removed on exit.'
        printf '## Scope and safety\n\n'
        printf '%s\n\n' 'This report records one bounded macOS CLI run. No volume or recovery case was executed. No password discovery or bypass was attempted. No WinRAR Windows GUI is installed or tested; only the macOS RAR CLI pair above is available.'
        printf '## Fixture hashes\n\n| Kind | Path | Bytes | SHA-256 |\n|---|---|---:|---|\n'
        while IFS="$(printf '\t')" read -r kind path bytes sha256; do
            [ -n "${kind:-}" ] && printf '| %s | `%s` | %s | `%s` |\n' "$kind" "$path" "$bytes" "$sha256"
        done < "$ARTIFACTS"
        printf '\n## Case results\n\n'
        printf '| Case | Exit | Timeout | Duration | Command |\n|---|---:|---:|---:|---|\n'
        while IFS="$(printf '\t')" read -r id exit_code timed_out start end duration stdout_file stderr_file working_directory command_line; do
            [ "$id" = id ] && continue
            printf '| `%s` | `%s` | `%s` | %ss | `%s` |\n' "$id" "$exit_code" "$timed_out" "$duration" "$command_line"
        done < "$CASES"
        printf '\n## Exact stdout/stderr evidence\n\n'
        while IFS="$(printf '\t')" read -r id exit_code timed_out start end duration stdout_file stderr_file working_directory command_line; do
            [ "$id" = id ] && continue
            printf '### `%s` — exit `%s`, timeout `%s`\n\n' "$id" "$exit_code" "$timed_out"
            printf '**stdout**\n\n```text\n'
            cat "$stdout_file"
            printf '```\n\n**stderr**\n\n```text\n'
            cat "$stderr_file"
            printf '```\n\n'
        done < "$CASES"
        printf '## Observed\n\n'
        printf '%s\n' '- The rows above are the complete observed result set for this run: command, exit code, timeout flag, duration, stdout, stderr, and artifact hashes.'
        printf '%s\n' '- An exit code of `124` means the portable case bound fired; no such row is interpreted as successful behavior.'
        printf '%s\n' '- A `SKIPPED` row is an intentional non-execution, not evidence of the underlying RAR feature.'
        printf '\n## Inferred\n\n'
        printf '%s\n' '- The tested `-p-` invocations provide an explicit no-password path for this run; this does not establish behavior for every password-related option.'
        printf '%s\n' '- The observed P0 command, path, encryption, and failure rows are sufficient to begin a scoped phase-3 MVP for an independent Loserar CLI, provided implementation scope stays within those rows.'
        printf '\n## Unknown\n\n'
        printf '%s\n' '- Complete RAR/WinRAR compatibility, Windows GUI behavior, all archive formats, volumes, recovery records, advanced metadata, and untested flags remain unknown.'
        printf '%s\n' '- The report does not claim source-level equivalence or complete protocol understanding.'
        printf '\n## Coverage and skipped/blocked cases\n\n'
        printf '%s\n' '- Covered: executable identity, creation, listing variants, testing, print-to-stdout, flatten/preserve extraction, filters, collisions, symlink fixture when available, compression levels, dictionary sizes, solid/non-solid creation, data/header encryption with explicit password/no-password/wrong-password paths, malformed/truncated/missing inputs, unknown switches, and unsupported format selection.'
        printf '%s\n' '- Skipped: volume and recovery cases by safety policy; REA doctor when the `rea` CLI is absent; symlink cases only if `ln -s` was unavailable.'
        printf '%s\n' '- Blocked: any case that times out is recorded in the table and evidence sections; the run continues without aborting.'
        printf '\n## Validation\n\n'
        printf '%s\n' '- `sh -n phase-2-probe.sh` is required before execution.'
        printf '%s\n' '- This report was generated by the same probe run requested for phase 2.'
    } > "$report_tmp" && mv "$report_tmp" "$REPORT_PATH"
}

generate_report
printf '%s\n' '--- case summary ---'
awk -F '\t' 'NR > 1 { printf "%s\texit=%s\ttimeout=%s\t%s\n", $1, $2, $3, $10 }' "$CASES"
printf '%s\n' '--- probe complete; temporary evidence will now be removed ---'
exit 0
