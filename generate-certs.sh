#!/bin/bash

set -e

CERT_DIR="./mount/certs"
DOMAIN="localhost"

mkdir -p "$CERT_DIR"

# Check openssl
if ! command -v openssl &> /dev/null; then
  echo "❌ OpenSSL is not installed."
  echo ""
  echo "Please install it first:"
  echo "  macOS:  brew install openssl"
  echo "  Ubuntu: sudo apt install openssl"
  echo "  Fedora: sudo dnf install openssl"
  echo ""
  exit 1
fi

echo "🔐 Generating self-signed certificate for $DOMAIN..."

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout "$CERT_DIR/localhost.key" \
  -out "$CERT_DIR/localhost.crt" \
  -subj "/C=IT/ST=Local/L=Local/O=Dev/OU=Dev/CN=$DOMAIN"

echo ""
echo "✅ Certificates generated in $CERT_DIR"
echo "⚠️  Browser will show a security warning (self-signed). This is normal."
