#!/usr/bin/env bash
# Update Formula/<name>.rb to a new release tag: bumps the url and sha256.
# Usage: scripts/update-formula.sh <name> <version>   (e.g. obi 0.2.0 — the vX.Y.Z tag must be pushed)
set -euo pipefail

NAME="${1:?usage: update-formula.sh <name> <version>}"
VERSION="${2:?usage: update-formula.sh <name> <version>}"
FORMULA="$(cd "$(dirname "$0")/.." && pwd)/Formula/${NAME}.rb"
URL="https://github.com/hmepas/${NAME}/archive/refs/tags/v${VERSION}.tar.gz"

echo "Fetching ${URL} ..."
SHA=$(curl -fsSL "$URL" | shasum -a 256 | awk '{print $1}')

sed -i '' -E "s|archive/refs/tags/v[0-9][^\"]*\.tar\.gz|archive/refs/tags/v${VERSION}.tar.gz|" "$FORMULA"
sed -i '' -E "s|^  sha256 \"[0-9a-f]+\"|  sha256 \"${SHA}\"|" "$FORMULA"

echo "Updated ${NAME}.rb: version ${VERSION}, sha256 ${SHA}"
