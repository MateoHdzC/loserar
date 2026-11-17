# Loserar macOS app

This directory contains the native SwiftUI shell and an AppKit fallback for Loserar. The app keeps the archive engine in the cross-platform Go CLI and invokes the bundled `Contents/MacOS/loserar` process.

## Build

```sh
./build.sh
```

The script preserves the supplied `../logo .webp`, converts it to PNG when `sips` is available, and creates `build/Loserar.app`. On machines with Command Line Tools but no full macOS SwiftUI SDK, it falls back to the native AppKit implementation in `LoserarApp.m`. The script also signs the local bundle ad hoc when `codesign` is available.

On macOS's default case-insensitive filesystem, `loserar` and `LoseRAR` cannot be separate filenames. The installer therefore stores the binary as `loserar-bin` and installs `LoseRAR` as the user-facing wrapper; both spellings execute the same CLI.
