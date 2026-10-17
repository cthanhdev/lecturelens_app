#!/usr/bin/env bash
# ==============================================================================
# LectureLens - Sign IPA with zsign & Install to iPhone via xtool
# ==============================================================================
set -e

BUNDLE_ID="com.lecturelens.app"

# 1. Check prerequisites
if ! command -v zsign &> /dev/null; then
    echo "Error: 'zsign' command not found. Please run './setup_wsl_xtool.sh' first."
    exit 1
fi

if ! command -v xtool &> /dev/null; then
    echo "Error: 'xtool' command not found. Please run './setup_wsl_xtool.sh' first."
    exit 1
fi

# 2. Parse arguments flexible to handle empty/omitted password
# Usage:
#   ./sign_and_install.sh <unsigned.ipa> <cert.p12> <profile.mobileprovision>
#   ./sign_and_install.sh <unsigned.ipa> <cert.p12> <password> <profile.mobileprovision> [output_signed.ipa]
IPA_INPUT="${1}"
P12_FILE="${2}"
P12_PASS=""
PROVISION_FILE=""
OUTPUT_IPA="LectureLens-signed.ipa"

if [ "$#" -lt 3 ]; then
    echo "Usage: ./sign_and_install.sh <unsigned.ipa> <cert.p12> [cert_password] <profile.mobileprovision> [output_signed.ipa]"
    echo ""
    echo "Examples:"
    echo "  # Without certificate password:"
    echo "  ./sign_and_install.sh LectureLens-unsigned.ipa dev.p12 embedded.mobileprovision"
    echo ""
    echo "  # With certificate password:"
    echo "  ./sign_and_install.sh LectureLens-unsigned.ipa dev.p12 \"123456\" embedded.mobileprovision"
    exit 1
fi

if [ "$#" -eq 3 ]; then
    PROVISION_FILE="${3}"
elif [ "$#" -ge 4 ]; then
    if [[ "${3}" == *.mobileprovision ]]; then
        PROVISION_FILE="${3}"
        OUTPUT_IPA="${4:-LectureLens-signed.ipa}"
    else
        P12_PASS="${3}"
        PROVISION_FILE="${4}"
        OUTPUT_IPA="${5:-LectureLens-signed.ipa}"
    fi
fi

# 3. Validate existence of input files
if [ ! -f "$IPA_INPUT" ]; then
    echo "Error: Unsigned IPA file not found at: '$IPA_INPUT'"
    exit 1
fi

if [ ! -f "$P12_FILE" ]; then
    echo "Error: Developer certificate (.p12) not found at: '$P12_FILE'"
    exit 1
fi

if [ ! -f "$PROVISION_FILE" ]; then
    echo "Error: Provisioning profile (.mobileprovision) not found at: '$PROVISION_FILE'"
    exit 1
fi

echo "=== [1/4] Signing IPA with zsign ==="
echo "Input IPA:     $IPA_INPUT"
echo "Certificate:   $P12_FILE"
echo "Provisioning:  $PROVISION_FILE"
echo "Output IPA:    $OUTPUT_IPA"

PASS_ARGS=()
if [ -n "$P12_PASS" ]; then
    PASS_ARGS=(-p "$P12_PASS")
fi

zsign -k "$P12_FILE" "${PASS_ARGS[@]}" -m "$PROVISION_FILE" -o "$OUTPUT_IPA" "$IPA_INPUT"

echo "=== [2/4] Restarting usbmuxd and verifying connected iOS devices ==="
sudo service usbmuxd restart || true
xtool devices || {
    echo "Warning: No connected devices detected by xtool."
    echo "Ensure:"
    echo "  1. iPhone is connected via USB and 'Trust This Computer' is accepted."
    echo "  2. 'attach_iphone.ps1' was run on Windows PowerShell as Administrator."
    echo "  3. Developer Mode is turned ON in iPhone Settings -> Privacy & Security."
}

echo "=== [3/4] Installing signed IPA to device via xtool ==="
xtool install "$OUTPUT_IPA"

echo "=== [4/4] Launching LectureLens app ==="
xtool launch "$BUNDLE_ID" || echo "Launch command sent. You can also tap the LectureLens icon on your iPhone home screen."

echo ""
echo ">>> Deployment completed successfully! Enjoy LectureLens on iOS."
