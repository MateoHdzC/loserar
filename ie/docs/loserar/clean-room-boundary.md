# Clean-Room Boundary

Loserar must be an independent implementation informed by observable behavior. This boundary keeps the work lawful, reviewable, and evidence-driven.

## Scope

The behavioral record concerns only:

- The supplied RARLAB macOS x86_64 RAR/UnRAR 7.23 executable identities.
- The exact paths and SHA-256 values recorded in [README.md](README.md).
- Self-owned test archives and other self-owned fixtures.
- The phase-1 observations listed in [observed-behavior.md](observed-behavior.md).

It does not claim access to, or reproduce, proprietary source code.

## Rules

1. **Independent implementation:** write Loserar from its own design, code, and tests.
2. **No proprietary code copying:** do not copy proprietary source, decompiled code, literals, or implementation text into Loserar.
3. **Observable evidence only:** base compatibility claims on repeatable command results from the identified executables and self-owned artifacts.
4. **No bypass guidance:** do not document or provide guidance for bypassing passwords, encryption, licensing, access controls, or other protections.
5. **Keep classifications explicit:** label each item as Observed, Hypothesis, Unknown, or Next test.
6. **Preserve identity:** tie each result to the executable path and SHA-256; do not silently mix builds.
7. **Record limitations:** a missing test result remains unknown; do not fill it with an assumption.

## Evidence boundary

| Allowed for compatibility evidence | Outside this boundary |
|---|---|
| Running the supplied executables against self-owned archives | Copying proprietary code into Loserar |
| Recording commands, outputs, paths, and exit codes | Presenting hypotheses as verified behavior |
| Comparing `e`, `x`, and `p` path/output behavior | Bypass guidance for passwords, encryption, or licensing |
| Testing the supplied exit-code cases | Generalizing from an untested build, platform, or artifact |
| Using REA readiness facts to plan analysis | Treating REA readiness as archive-behavior evidence |

## Hypothesis

- A clean-room implementation can use the recorded external contract without reproducing proprietary implementation details. The adequacy of that contract remains to be tested.

## Unknown

- Whether additional observations would materially change the implementation boundary.
- Which untested RAR5 features, options, and edge cases require separate compatibility decisions.

## Next test

Run only evidence-driven tests on self-owned artifacts. For each test, preserve the exact executable identity, command, inputs, outputs, and exit code; then update the appropriate observed or unknown record without adding unsupported claims.

## Limitations

This boundary does not grant permission to copy, redistribute, or bypass anything. It defines documentation and implementation constraints for an independent project; it is not legal advice.
