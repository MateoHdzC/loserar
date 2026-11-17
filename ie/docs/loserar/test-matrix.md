# Loserar Test Matrix

Use this matrix to keep the implementation evidence-driven. **Observed** means the phase-1 or bounded phase-2 run recorded the behavior; **Skipped** means the probe intentionally did not execute the case; **Next test** means no result is asserted here.

## Matrix

| Area | Test case | Command surface | Current status | Record next |
|---|---|---|---|---|
| Identity | `rar` executable matches the supplied SHA-256 | N/A | Observed | Recheck only if the executable changes |
| Identity | `unrar` executable matches the supplied SHA-256 | N/A | Observed | Recheck only if the executable changes |
| Creation | Supplied archive operation | `rar a` | Observed exit `0` with self-owned fixture | Fixture, archive hash, stdout/stderr, exit code |
| Format | Default archive format | RAR5 | Observed | Additional format/option cases |
| Listing | Basic listing | `unrar l` | Observed exit `0` for normal/data-encrypted archives; header-encrypted no-password exit `11` | Stored names, metadata, ordering, output text |
| Listing | Detailed listing | `unrar lt`, `lta`, `lb` | Observed exit `0` on normal self-owned fixture | Differences from `l`, metadata, output text |
| Integrity | Archive test | `rar t`, `unrar t` | Observed clean exit `0`, truncated exit `1`, wrong password exit `11` | Malformed and advanced archive fixtures |
| Output | Print stored content | `unrar p` | Observed: writes selected member content to stdout; selector uses the exact stored path | Bytes, separators, multi-file behavior, errors |
| Extraction | Flatten paths | `unrar e` | Observed: flattens paths | Collisions, nested paths, empty directories |
| Extraction | Preserve paths | `unrar x` | Observed: preserves paths | Path normalization, collisions, empty directories |
| Encryption | Data encryption | `rar a -p`, `unrar t -p...` | Observed known password exit `0`, wrong password exit `11` | Password success/failure and command-specific output |
| Encryption | Header encryption | `rar a -hp`, `unrar l/t -p...` | Observed known password exit `0`, no/wrong password exit `11` | Listing, testing, printing, and extraction behavior |
| Compression | Levels and dictionary | `rar a -m0..-m5`, `-md1m`, `-md64k` | Observed `0` for levels and `-md1m`; `-md64k` exit `7` | Larger fixtures and supported dictionary range |
| Modes | Solid/non-solid | `rar a -s`, `rar a -s-` | Observed exit `0` | Multi-file compression comparison |
| Failure | Successful operation | Relevant command | Observed exit code `0` | Per-command stdout/stderr and boundary cases |
| Failure | Missing archive | Relevant command | Observed exit code `10` | Exact diagnostic text and command coverage |
| Failure | Truncated input | Relevant command | Observed exit code `1` | Fixture construction and command coverage |
| Failure | Wrong password | Relevant command | Observed exit code `11` | Data/header encryption command coverage |
| Failure | Unknown `-ma4` | Relevant command | Observed exit code `7` | Exact accepted/rejected syntax and diagnostics |
| Failure | Unknown switch asymmetry | `unrar t -LoserarUnknownSwitch`, `rar t -LoserarUnknownSwitch` | Observed `unrar` exit `7`; tested `rar` invocation exit `0` | Repeat with a dedicated switch matrix |
| Volumes | Volume creation/testing | `rar a -v`, `rar v`, `unrar t` | Skipped by safety policy | Controlled noninteractive harness |
| Recovery | Recovery records/volumes | `rar a -rr/-rv`, `rar v`, `unrar t` | Skipped by safety policy | Controlled noninteractive harness |
| Tooling | REA readiness | REA doctor | Observed: 255 tools, 6 prompts, `binary_session` | Restart Codex before using direct tools |

## Evidence record template

For every **Next test**, capture:

| Field | Required value |
|---|---|
| Executable | Absolute path and SHA-256 |
| Fixture | Self-owned input description and hash |
| Command | Exact command line |
| Output | stdout, stderr, paths, and output hashes where applicable |
| Result | Exit code and observed interpretation |
| Classification | Observed, Hypothesis, Unknown, or blocked |

## Hypothesis

- Repeating the same fixture and command with the same executable identity should make a useful deterministic compatibility check. This must be validated rather than assumed.

## Unknown

- No result is asserted for matrix rows whose status says command surface only or Next test.
- The matrix does not establish complete RAR5 coverage or complete option coverage.

## Next test

Prioritize one self-owned fixture per row, then add boundary cases only when the first result leaves a concrete question. Preserve the original evidence and append the new result; do not rewrite an unverified outcome as fact.

## Limitations

The matrix is a test plan plus a bounded record of supplied observations. It is not a conformance suite and does not provide unverified expected outputs.
