# ==============================================================================
# LectureLens - Attach iPhone to WSL2 using usbipd-win
# Run this script in PowerShell as Administrator
# ==============================================================================

# Verify usbipd is installed
if (-not (Get-Command "usbipd" -ErrorAction SilentlyContinue)) {
    Write-Host "Error: 'usbipd' command not found." -ForegroundColor Red
    Write-Host "Please install it by running:" -ForegroundColor Yellow
    Write-Host "  winget install dorssel.usbipd-win" -ForegroundColor White
    exit 1
}

# Check Administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Warning: Sharing USB devices via usbipd requires Administrator privileges." -ForegroundColor Yellow
    Write-Host "If you encounter permission errors, please restart PowerShell as Administrator." -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "=== Listing connected USB devices ===" -ForegroundColor Cyan
usbipd list

Write-Host ""
$busid = Read-Host "Enter the BUSID corresponding to Apple Mobile Device / iPhone (e.g. 1-3)"
$busid = $busid.Trim()

if ([string]::IsNullOrWhiteSpace($busid)) {
    Write-Host "No BUSID provided. Exiting." -ForegroundColor Yellow
    exit 1
}

# 1. Ensure device is bound (shared) first
Write-Host "Step 1: Ensuring BUSID $busid is shared with WSL (binding)..." -ForegroundColor Yellow
usbipd bind --busid $busid --force 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Device may already be bound or require Admin privileges. Proceeding to attach..." -ForegroundColor Gray
}

# 2. Attach device to WSL2
Write-Host "Step 2: Attaching BUSID $busid to WSL2..." -ForegroundColor Green
usbipd attach --wsl --busid $busid

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host ">>> Successfully attached iPhone to WSL2!" -ForegroundColor Green
    Write-Host ">>> Next steps:" -ForegroundColor Cyan
    Write-Host "    1. Open WSL2 terminal (wsl)" -ForegroundColor White
    Write-Host "    2. Run 'sudo service usbmuxd restart'" -ForegroundColor White
    Write-Host "    3. Run 'xtool devices' to confirm your device is recognized." -ForegroundColor White
    Write-Host "    (Tip: Use 'usbipd attach --wsl --busid $busid --auto-attach' to keep it connected across unplug/replug)" -ForegroundColor DarkGray
} else {
    Write-Host "Failed to attach device. Please ensure WSL is running and run PowerShell as Administrator." -ForegroundColor Red
}
