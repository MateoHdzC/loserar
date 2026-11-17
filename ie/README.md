# Loserar

Loserar is an independent archive tool for macOS and Windows terminal workflows, with a native macOS desktop shell. It is not RAR-compatible and does not include proprietary WinRAR code.

## CLI

```sh
cd loserar
GOCACHE=/tmp/loserar-go-cache go test ./...
GOCACHE=/tmp/loserar-go-cache go build -o loserar .
./loserar create backup.loser Documents
./loserar test backup.loser
./loserar extract backup.loser restored
```

For Windows, run `loserar/build-windows.ps1` in PowerShell. To install the terminal command `LoseRAR` on macOS:

```sh
./loserar/install-command.sh
```

Launching `loserar` or `LoseRAR` without arguments in a TTY opens the custom colored Loserar Console with a banner, spinner, prompt, and interactive archive commands. Scripted and piped invocations keep the non-interactive CLI behavior.

## macOS app

```sh
./LoserarApp/build.sh
open LoserarApp/build/Loserar.app
```

The app uses the supplied `logo .webp`, bundles the CLI, and supports Create, List, Extract, and Test. The build uses SwiftUI when available and a native AppKit fallback otherwise.

See `docs/loserar/phase-3-design.md` for the format and security model, and `docs/loserar/clean-room-boundary.md` for the reverse-engineering boundary.
