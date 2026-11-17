# Loserar phase 3 design

Phase 3 creates an independent Loserar MVP: a small Go archive engine shared by macOS and Windows CLI builds, plus a native macOS shell that invokes the CLI. It is intentionally not a RAR implementation and does not claim RAR compatibility.

## Quick path

```sh
cd /Users/mateo.hdz/Documents/ie/loserar
GOCACHE=/tmp/loserar-go-cache go test ./...
GOCACHE=/tmp/loserar-go-cache go build -o loserar .
./loserar create sample.loser folder
./loserar test sample.loser
./loserar extract sample.loser out
```

## Architecture

| Layer | Responsibility |
|---|---|
| `archive.go` | Format encoding/decoding, compression, CRC validation, path safety, extraction |
| `main.go` | Cross-platform command parsing and terminal presentation |
| `archive_test.go` | Round-trip, corruption, path, and overwrite behavior |
| `LoserarApp/LoserarApp.swift` | SwiftUI/AppKit UI and native file panels |

The app is a thin client. The archive engine is not duplicated in Swift; the app runs the bundled `Contents/MacOS/loserar` process and displays its output.

## `.loser` v1 format

All integers are little-endian. Entries are sorted lexicographically by normalized member name.

| Field | Size | Meaning |
|---|---:|---|
| magic | 4 | ASCII `LOSR` |
| version | 2 | `1` |
| flags | 2 | `0` in v1 |
| entry count | 4 | Number of entries |
| name length | 4 | UTF-8 member name length |
| name | variable | Slash-normalized relative path |
| kind | 1 | `0` file, `1` directory |
| mode | 4 | Portable permission bits |
| mtime | 8 | Unix nanoseconds |
| logical size | 8 | Uncompressed file size |
| stored size | 8 | Payload size |
| method | 1 | `0` store, `1` raw DEFLATE |
| CRC-32 | 4 | CRC of the logical file bytes |
| payload | variable | Present for files only |

The creator chooses raw DEFLATE only when it is smaller than stored bytes. Directories have no payload. The format is deterministic in member ordering and layout, but source metadata such as modification times remains part of the archive.

## Security model

- Absolute names, drive-qualified names, and `..` components are rejected on creation and reading.
- Extraction checks the resolved destination path and rejects symlink parents/targets.
- Existing files are not overwritten unless `extract --force` is supplied; symlinks are rejected even with force.
- Header sizes are bounded before allocation, truncated payloads fail, and CRC/decoded-size checks detect corruption.
- Archive creation writes a temporary sibling and renames it only after the complete file is written.

## Compatibility boundary

Loserar does not read or write RAR headers, RAR compression methods, recovery records, volumes, encryption, solid blocks, extended attributes, or WinRAR metadata. Those remain future compatibility work only if independently designed and legally authorized. Phase 1/2 observations are treated as behavioral inspiration for command ergonomics, not copied implementation.

## Decisions and non-goals

- Go standard library only: easy macOS/Windows cross-build and no dependency supply-chain surface.
- Native macOS UI rather than Electron: small thin client, native file panels, and the supplied logo remain first-class.
- No Windows GUI in this slice; `build-windows.ps1` produces `loserar.exe`.
- No passwords, multi-volume archives, recovery records, or RAR import in this MVP.
