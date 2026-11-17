#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PREFIX=${PREFIX:-"$HOME/.local/bin"}
mkdir -p "$PREFIX"
GOCACHE=${GOCACHE:-/tmp/loserar-go-cache} go -C "$ROOT" build -trimpath -o "$PREFIX/loserar-bin" .
cat > "$PREFIX/LoseRAR" <<EOF
#!/bin/sh
exec "$PREFIX/loserar-bin" "\$@"
EOF
chmod +x "$PREFIX/loserar-bin" "$PREFIX/LoseRAR"
echo "Installed LoseRAR to $PREFIX/LoseRAR"
echo "Add $PREFIX to PATH if the command is not found."
