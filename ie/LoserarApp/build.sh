#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
APP="$ROOT/LoserarApp/build/Loserar.app"
CLI="$APP/Contents/MacOS/loserar"
SWIFT_OUT="$APP/Contents/MacOS/LoserarApp"
OBJC_OUT="$APP/Contents/MacOS/LoserarApp"
SWIFT_LOG="$ROOT/LoserarApp/build/swift-build.log"
OBJC_LOG="$ROOT/LoserarApp/build/objc-build.log"
SIGN_LOG="$ROOT/LoserarApp/build/codesign.log"
UNAVAILABLE="$ROOT/LoserarApp/build/APP_BUILD_UNAVAILABLE.txt"

rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"

GOCACHE=${GOCACHE:-/tmp/loserar-go-cache} go -C "$ROOT/loserar" build -trimpath -o "$CLI" .
cp "$ROOT/LoserarApp/Info.plist" "$APP/Contents/Info.plist"

if command -v sips >/dev/null 2>&1; then
  sips -s format png "$ROOT/logo .webp" --out "$APP/Contents/Resources/logo.png" >/dev/null
else
  cp "$ROOT/logo .webp" "$APP/Contents/Resources/logo.webp"
fi

if command -v swiftc >/dev/null 2>&1; then
  if swiftc -parse-as-library -framework SwiftUI -framework AppKit -o "$SWIFT_OUT" "$ROOT/LoserarApp/LoserarApp.swift" 2>"$SWIFT_LOG"; then
    if command -v codesign >/dev/null 2>&1; then codesign --deep --force --sign - "$APP" >"$SIGN_LOG" 2>&1 || true; fi
    chmod +x "$SWIFT_OUT" "$CLI"
    echo "Built $APP"
    exit 0
  fi
fi

if command -v clang >/dev/null 2>&1; then
  if clang -fobjc-arc -framework Cocoa -mmacosx-version-min=12.0 -o "$OBJC_OUT" "$ROOT/LoserarApp/LoserarApp.m" 2>"$OBJC_LOG"; then
    if command -v codesign >/dev/null 2>&1; then codesign --deep --force --sign - "$APP" >"$SIGN_LOG" 2>&1 || true; fi
    chmod +x "$OBJC_OUT" "$CLI"
    echo "Built $APP using the AppKit fallback"
    exit 0
  fi
fi

cat > "$UNAVAILABLE" <<EOF
The Loserar source and CLI bundle were prepared, but this machine does not have
a matching macOS SwiftUI/AppKit toolchain needed to link the GUI binary.

Sources: $ROOT/LoserarApp/LoserarApp.swift and $ROOT/LoserarApp/LoserarApp.m
CLI: $CLI
See $SWIFT_LOG and $OBJC_LOG for the exact compiler output.
EOF
echo "GUI source prepared; native link unavailable. See $UNAVAILABLE" >&2
exit 0
