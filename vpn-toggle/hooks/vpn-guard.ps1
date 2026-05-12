# vpn-guard.ps1 — preToolUse hook
# Ensures MSFT-AzVPN-Manual is connected before any whitelisted MCP tool runs.
# Reads camelCase preToolUse JSON payload from stdin.
# Exit 0 with no stdout = default allow.

$ErrorActionPreference = 'Stop'

# Tools that require corp VPN. Matched as a regex against toolName.
$guardedPattern = '^(msx-|mcaps-iq)'
$vpnName = 'MSFT-AzVPN-Manual'
$settleSeconds = 5
$logPath = Join-Path $env:USERPROFILE '.copilot\hooks\vpn-guard.log'

function Write-Log($msg) {
    try {
        $ts = (Get-Date).ToString('s')
        Add-Content -Path $logPath -Value "[$ts] $msg" -ErrorAction SilentlyContinue
    } catch { }
}

try {
    $raw = [Console]::In.ReadToEnd()
    if (-not $raw) { exit 0 }
    $payload = $raw | ConvertFrom-Json -ErrorAction Stop
    $toolName = $payload.toolName
    if (-not $toolName) { $toolName = $payload.tool_name }  # VS Code variant
    if (-not $toolName) { exit 0 }

    if ($toolName -notmatch $guardedPattern) { exit 0 }

    $status = & rasdial 2>&1 | Out-String
    if ($status -match [regex]::Escape($vpnName)) {
        # Already connected
        exit 0
    }

    Write-Log "Tool '$toolName' requires VPN; dialing $vpnName"
    $dial = & rasdial $vpnName 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) {
        $reason = "Failed to connect $vpnName before '$toolName'. rasdial output: $($dial.Trim())"
        Write-Log $reason
        $out = @{
            permissionDecision = 'deny'
            permissionDecisionReason = $reason
        } | ConvertTo-Json -Compress
        Write-Output $out
        exit 0
    }

    Start-Sleep -Seconds $settleSeconds
    Write-Log "VPN up; allowing '$toolName' after ${settleSeconds}s settle"
    exit 0
} catch {
    Write-Log "vpn-guard error: $_"
    # Fail open: don't block tools just because the hook had an internal error.
    exit 0
}
