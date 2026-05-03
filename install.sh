#!/bin/sh
# idp installer — pulls the right binary for your OS/arch from GitHub Releases.
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/SrimanMayandi02/idp/main/install.sh | sh
#   IDP_VERSION=v0.1.0 curl -fsSL ... | sh   # pin a specific version

set -e

REPO="SrimanMayandi02/idp"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"

# Detect OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case "$OS" in
  linux|darwin) ;;
  *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

# Detect arch
ARCH=$(uname -m)
case "$ARCH" in
  x86_64|amd64) ARCH="amd64" ;;
  aarch64|arm64) ARCH="arm64" ;;
  *) echo "Unsupported arch: $ARCH"; exit 1 ;;
esac

# Resolve version
if [ -n "$IDP_VERSION" ]; then
  VERSION="$IDP_VERSION"
else
  VERSION=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
    | grep '"tag_name"' | cut -d '"' -f 4)
fi

if [ -z "$VERSION" ]; then
  echo "Could not determine latest version. Set IDP_VERSION manually."
  exit 1
fi

# GoReleaser archive naming uses the version without the leading "v"
VERSION_NO_V="${VERSION#v}"
ARCHIVE="idp_${VERSION_NO_V}_${OS}_${ARCH}.tar.gz"
URL="https://github.com/$REPO/releases/download/$VERSION/$ARCHIVE"

echo "Downloading idp $VERSION ($OS/$ARCH)..."
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

curl -fsSL "$URL" | tar -xz -C "$TMP"

echo "Installing to $INSTALL_DIR..."
if [ -w "$INSTALL_DIR" ]; then
  mv "$TMP/idp" "$INSTALL_DIR/idp"
else
  sudo mv "$TMP/idp" "$INSTALL_DIR/idp"
fi

echo ""
echo "Installed. Run it:"
echo ""
"$INSTALL_DIR/idp"