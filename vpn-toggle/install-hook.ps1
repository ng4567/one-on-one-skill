# Install the vpn-guard preToolUse hook into the user's Copilot hooks directory.
# Run from anywhere; this script resolves its own location.

$ErrorActionPreference = 'Stop'
$srcDir = Join-Path $PSScriptRoot 'hooks'
$dstDir = Join-Path $env:USERPROFILE '.copilot\hooks'
New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
Copy-Item -Path (Join-Path $srcDir 'vpn-guard.ps1')  -Destination $dstDir -Force
Copy-Item -Path (Join-Path $srcDir 'vpn-guard.json') -Destination $dstDir -Force
Write-Host "Installed vpn-guard hook to $dstDir. Restart any active Copilot CLI session for it to take effect."
