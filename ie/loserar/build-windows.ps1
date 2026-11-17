$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $root
try {
  New-Item -ItemType Directory -Force -Path dist | Out-Null
  $env:GOOS = 'windows'
  $env:GOARCH = 'amd64'
  go build -trimpath -o dist/loserar.exe .
  Write-Host "Built dist/loserar.exe"
} finally { Pop-Location }
