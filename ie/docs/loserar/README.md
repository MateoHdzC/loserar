# Loserar Phase-2 Behavioral Record

This directory records phase-1 and phase-2 behavioral evidence for an independent Loserar implementation. Phase 2 is a bounded macOS CLI study, not a complete reverse-engineering report.

## Scope at a glance

- **Target identity:** supplied official RARLAB macOS x86_64 RAR/UnRAR 7.23 executables.
- **Artifact boundary:** observations came from the supplied executable identities and self-owned test archives.
- **Observed command surface:** `rar a`, `rar l`, `rar t`, `unrar l`, `unrar lt`, `unrar lta`, `unrar lb`, `unrar t`, `unrar p`, `unrar e`, and `unrar x`.
- **Observed format default:** RAR5.
- **Phase-2 run:** bounded, noninteractive probe completed; see [phase-2-report.md](phase-2-report.md).
- **REA status:** the phase-2 probe recorded exit 1 for the configured `rea mcp doctor`; the earlier standalone doctor run passed with 255 tools, 6 prompts, and `binary_session`. Direct tools require a Codex restart.

## Executable identities

| Tool | Path | SHA-256 |
|---|---|---|
| `rar` | `/Users/mateo.hdz/Documents/ie/tools/rar/rar/rar` | `2512979417b2ba1c60f1a5783051931928099c3f407be8a12ef030c9cb54a8fb` |
| `unrar` | `/Users/mateo.hdz/Documents/ie/tools/rar/rar/unrar` | `4a68e200b32ef9a6e2a4771a9d7cba7dcb1555d9b05556467b81aa8265a1edd8` |

## Review path

1. Read [observed-behavior.md](observed-behavior.md) for the bounded evidence ledger.
2. Use [test-matrix.md](test-matrix.md) to distinguish observed behavior from untested cases.
3. Apply [clean-room-boundary.md](clean-room-boundary.md) before implementing or extending Loserar.

## Evidence ledger

### Observed

- The supplied tools expose the command surface listed above.
- `e` flattens paths, `x` preserves paths, and `p` writes the selected member's content to stdout while matching the exact stored path.
- Observed exit codes include `0` success, `10` missing archive, `1` truncated, `11` wrong password, and `7` unknown `-ma4`.
- Data and header encryption were observed on self-owned archives.
- Exact `p` selectors containing `./` or an internal `..` segment did not match the stored member and returned exit `10` in the phase-2 fixture.
- Compression levels `-m0` through `-m5`, `-md1m`, solid `-s`, and non-solid `-s-` completed successfully in the phase-2 fixture; `-md64k` returned exit `7`.
- Missing and truncated archives returned exits `10` and `1`; the self-owned plain-text malformed fixture returned exit `0` and therefore needs separate interpretation rather than being labeled corruption.
- Volume and recovery-record cases were intentionally skipped because they were not proven noninteractive in the probe.

### Hypothesis

- These observations are suitable as initial compatibility targets for an independent implementation. They do not establish complete format or option compatibility.

### Unknown

- Behavior outside the listed commands, options, archive contents, encryption cases, and self-owned fixtures.
- Whether the listed outcomes hold across other executable builds or archive versions.

### Next test

- Run the remaining volume, recovery, metadata, and cross-platform cases in a separately controlled harness.
- Begin only a scoped phase-3 MVP for terminal and macOS using the verified external contract; do not claim full RAR compatibility.

## Limitations

This record does not claim source-level equivalence, complete protocol coverage, or complete reverse engineering. It reports only the supplied phase-1 facts and the bounded phase-2 run, while keeping skipped and unverified behavior explicitly open.
