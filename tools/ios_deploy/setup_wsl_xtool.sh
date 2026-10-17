#!/usr/bin/env bash
# ==============================================================================
# LectureLens - iOS Deployment Toolchain Setup Script for WSL2 (Ubuntu)
# ==============================================================================
set -e

echo "=== [1/5] Updating apt and installing core dependencies ==="
sudo apt update
sudo apt install -y usbmuxd libimobiledevice-utils libimobiledevice6 curl git unzip zlib1g-dev g++ pkg-config libssl-dev make

# Install libfuse for AppImage support in WSL2 if available on this distro
sudo apt install -y libfuse2 || sudo apt install -y libfuse2t64 || true

echo "=== [2/5] Building and installing zsign ==="
if command -v zsign &> /dev/null; then
    echo "zsign is already installed: $(which zsign)"
else
    echo "Cloning and compiling zsign from source..."
    TMP_ZSIGN=$(mktemp -d)
    git clone --depth 1 https://github.com/zhlynn/zsign.git "$TMP_ZSIGN"
    make -C "$TMP_ZSIGN/build/linux"
    sudo cp "$TMP_ZSIGN/bin/zsign" /usr/local/bin/zsign
    sudo chmod +x /usr/local/bin/zsign
    rm -rf "$TMP_ZSIGN"
    echo "zsign installed successfully to /usr/local/bin/zsign"
fi

echo "=== [3/5] Downloading and configuring latest xtool AppImage ==="
ARCH=$(uname -m)
XTOOL_URL="https://github.com/xtool-org/xtool/releases/latest/download/xtool-${ARCH}.AppImage"
echo "Fetching: ${XTOOL_URL}"

TMP_XTOOL="/tmp/xtool-${ARCH}.AppImage"
curl -fL "${XTOOL_URL}" -o "${TMP_XTOOL}"
chmod +x "${TMP_XTOOL}"

# In WSL2, AppImages can be extracted into /opt/xtool to eliminate FUSE runtime dependencies
echo "Extracting xtool to /opt/xtool for seamless WSL2 execution..."
sudo rm -rf /opt/xtool /tmp/squashfs-root
(cd /tmp && "${TMP_XTOOL}" --appimage-extract > /dev/null 2>&1) || true

if [ -d "/tmp/squashfs-root" ]; then
    sudo mv /tmp/squashfs-root /opt/xtool
    sudo ln -sf /opt/xtool/AppRun /usr/local/bin/xtool
    rm -f "${TMP_XTOOL}"
    echo "xtool extracted to /opt/xtool and symlinked to /usr/local/bin/xtool"
else
    # Fallback to direct AppImage binary
    sudo mv "${TMP_XTOOL}" /usr/local/bin/xtool
    echo "xtool binary placed at /usr/local/bin/xtool"
fi

echo "=== [4/5] Ensuring usbmuxd service is active ==="
sudo service usbmuxd restart || true

echo "=== [5/5] Verifying toolchain installation ==="
echo -n "zsign: " && (zsign -v 2>&1 || echo "installed")
echo -n "xtool: " && (xtool --version 2>&1 || echo "installed")

echo ""
echo ">>> Setup completed successfully!"
echo ">>> Connect your iPhone via USB, run 'attach_iphone.ps1' on Windows,"
echo ">>> then run './sign_and_install.sh <path-to-unsigned.ipa> <path-to-p12> [password] <path-to-mobileprovision>'."
