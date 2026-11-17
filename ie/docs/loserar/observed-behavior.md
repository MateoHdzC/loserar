# Observed Behavior

This record is bound to the supplied executable identities and to self-owned test artifacts. It reports observed outcomes only; it does not generalize beyond the stated scope. The full phase-2 capture is in [phase-2-report.md](phase-2-report.md).

## Target identity

| Tool | Version/platform supplied | Path | SHA-256 |
|---|---|---|---|
| `rar` | RARLAB macOS x86_64 7.23 | `/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar` | `2512979417b2ba1c60f1a5783051931928099c3f407be8a12ef030c9cb54a8fb` |
| `unrar` | RARLAB macOS x86_64 7.23 | `/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar` | `4a68e200b32ef9a6e2a4771a9d7cba7dcb1555d9b05556467b81aa8265a1edd8` |

## Observed

### Command surface

| Operation observed | Command |
|---|---|
| Archive operation | `rar a` |
| List | `unrar l` |
| Detailed list | `unrar lt` |
| Test | `unrar t` |
| Print | `unrar p` |
| Extract without preserved paths | `unrar e` |
| Extract with preserved paths | `unrar x` |

The default archive format observed was RAR5.

### Path handling and output

| Command | Observed result |
|---|---|
| `unrar e` | Flattens paths. |
| `unrar x` | Preserves paths. |
| `unrar p` | Writes the selected member's content to stdout; the member selector must match the exact stored path. |

In the phase-2 fixture, selectors containing `./` or an internal `..` segment did not match the stored member and returned exit `10`.

### Exit codes

| Exit code | Observed meaning |
|---:|---|
| `0` | Success |
| `1` | Truncated |
| `7` | Unknown `-ma4` |
| `10` | Missing archive |
| `11` | Wrong password |

### Encryption

Data encryption and header encryption were observed on self-owned archives. Known passwords succeeded; wrong passwords returned exit `11`; header listing without a password also returned exit `11`.

### Compression and archive modes

The phase-2 fixture completed creation with `-m0` through `-m5`, `-md1m`, `-s`, and `-s-`. The same small fixture produced identical archive sizes for `-m0` through `-m5`; this is an observation of that fixture, not a general compression claim. `-md64k` returned exit `7`.

### Failures and skipped cases

- Missing archives returned exit `10`.
- Truncated archives returned exit `1`.
- The self-owned plain-text malformed fixture returned exit `0` for both `rar l` and `unrar l`; this is recorded as an observed quirk, not proof that arbitrary malformed input is accepted.
- An unknown switch returned exit `7` for `unrar` but exit `0` for the tested `rar t` invocation.
- Volume and recovery-record cases were skipped by the safety policy of the probe.

### REA readiness

The earlier standalone REA doctor run passed with 255 tools, 6 prompts, and `binary_session`. The phase-2 probe invocation returned exit `1`, so this run does not treat REA readiness as verified. Direct tools require a Codex restart. This is tooling status, not archive behavior.

## Hypothesis

- The command and result distinctions above form a useful initial external contract for Loserar compatibility work.
- The supplied exit-code meanings may be stable for the tested command paths, but stability outside those paths is not established.

These are implementation hypotheses, not observed facts.

## Unknown

- Unlisted commands, flags, defaults, output formatting, metadata, and failure modes.
- Behavior for archive contents or passwords outside the self-owned test artifacts.
- Compatibility across other RAR/UnRAR builds, platforms, or archive versions.
- Whether every RAR5 feature follows the listed path and exit-code behavior.

## Next test

For each new case, use a self-owned fixture and record:

1. The exact executable path and SHA-256.
2. The complete command line and working-directory assumptions.
3. The input archive and relevant file hashes.
4. Standard output, standard error, extracted paths, and exit code.
5. Whether the result is observed, inferred, or still unknown.

Do not promote a hypothesis to an observed behavior without a repeatable result.

## Limitations

This is phase-1 plus bounded phase-2 behavioral evidence, not complete reverse engineering. No claim is made about internal implementation, source code, Windows GUI behavior, volume/recovery behavior, or any behavior not listed here.
