# Loserar CLI

Loserar is an independent archive tool. Its `.loser` format is not RAR-compatible and is designed for a small, inspectable first version.

## Build

```sh
GOCACHE=/tmp/loserar-go-cache go test ./...
GOCACHE=/tmp/loserar-go-cache go build -o loserar .
GOOS=windows GOARCH=amd64 GOCACHE=/tmp/loserar-go-cache go build -o loserar.exe .
```

## Use

```sh
loserar create backup.loser Documents Pictures
loserar list backup.loser
loserar test backup.loser
loserar extract backup.loser restored
loserar cat backup.loser Documents/notes.txt
```

Run `loserar` or `LoseRAR` without arguments from an interactive terminal to open the visual Loserar Console. It includes a colored banner, loading spinner, prompt, built-in commands such as `help`, `clear`, `cd`, and `theme`, and the archive commands above.

Use `--level 0..9` with `create`, `--force` with `extract`, and `--no-color` for plain output. The MVP supports regular files/directories, store/raw-DEFLATE compression, CRC-32 validation, and safe extraction. Encryption, volumes, recovery records, and RAR import are intentionally out of scope.
