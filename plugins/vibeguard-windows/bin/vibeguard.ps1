# Windows launcher for the VibeGuard plugin.
# Detects arch, exposes LEGIT_CLI_PATH, and passes auth/ping/logout through to
# the bundled legit binary so customers have a runnable command from inside
# the plugin tree (no `legit` on PATH required).

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$arch = 'amd64'
if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64' -or $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64') {
    $arch = 'arm64'
}

$binary      = Join-Path $scriptDir "vibeguard-windows-$arch.exe"
$legitBinary = Join-Path $scriptDir "legit-windows-$arch.exe"

if (-not (Test-Path $binary)) {
    Write-Error "Unsupported platform: windows-$arch"
    exit 1
}

if (-not $env:LEGIT_CLI_PATH -and (Test-Path $legitBinary)) {
    $env:LEGIT_CLI_PATH = $legitBinary
}

# Passthrough for known legit-cli subcommands.
if ($args.Count -gt 0 -and @('auth', 'ping', 'logout') -contains $args[0]) {
    if (-not (Test-Path $legitBinary)) {
        Write-Error "Bundled legit binary not found for windows-$arch"
        exit 1
    }
    & $legitBinary @args
    exit $LASTEXITCODE
}

& $binary @args
exit $LASTEXITCODE
