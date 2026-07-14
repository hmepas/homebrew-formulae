#!/usr/bin/env bash
# Update Formula/grappa.rb to a new release tag: bumps the url and sha256.
# Usage: scripts/update-formula.sh <version>   (e.g. 0.1.0 — the vX.Y.Z tag must be pushed)
set -euo pipefail

VERSION="${1:?usage: update-formula.sh <version>}"
FORMULA="$(cd "$(dirname "$0")/.." && pwd)/Formula/grappa.rb"
URL="https://github.com/hmepas/grappa/archive/refs/tags/v${VERSION}.tar.gz"

echo "Fetching ${URL} ..."
SHA=$(curl -fsSL "$URL" | shasum -a 256 | awk '{print $1}')

sed -i '' -E "s|archive/refs/tags/v[0-9][^\"]*\.tar\.gz|archive/refs/tags/v${VERSION}.tar.gz|" "$FORMULA"
sed -i '' -E "s|^  sha256 \"[0-9a-f]+\"|  sha256 \"${SHA}\"|" "$FORMULA"

echo "Updated grappa.rb: version ${VERSION}, sha256 ${SHA}"
