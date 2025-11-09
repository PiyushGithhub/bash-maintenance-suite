#!/usr/bin/env bash
set -Eeuo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

echo "[*] Setting executable permissions..."
chmod +x suite.sh scripts/*.sh

echo "[*] Ensuring backup destination and logs directory exist..."
# shellcheck source=/dev/null
source "./config.env"
mkdir -p "$BACKUP_DEST_DIR" "./logs"

echo "[*] Optional: install shellcheck (recommended)"
echo "    - Debian/Ubuntu: sudo apt-get install -y shellcheck"
echo "    - Fedora: sudo dnf install -y ShellCheck"
echo "    - Arch: sudo pacman -S --noconfirm shellcheck"
echo "    - openSUSE: sudo zypper install -y ShellCheck"
echo "    - Alpine: sudo apk add shellcheck"

echo "[*] Done. Run ./suite.sh to start."
