\
param(
  [Parameter(Mandatory=$true)][string]$ProjectRoot,
  [ValidateSet("Release","Debug")][string]$Config = "Release",
  [string]$Version = "0.1.0",
  [string]$BuildDir = "build",
  [string]$InnoSetupPath = "$env:ProgramFiles(x86)\Inno Setup 6\ISCC.exe"
)

$ErrorActionPreference = "Stop"

function Assert-Path($p, $msg) {
  if (-not (Test-Path $p)) { throw $msg }
}

Write-Host "== DJ Mike Pro: Build + Stage + Installer (Windows) ==" -ForegroundColor Cyan
Write-Host "ProjectRoot: $ProjectRoot"
Write-Host "Config:      $Config"
Write-Host "Version:     $Version"
Write-Host "BuildDir:    $BuildDir"
Write-Host "ISCC:        $InnoSetupPath"

Assert-Path $ProjectRoot "ProjectRoot not found: $ProjectRoot"
Assert-Path "$ProjectRoot\CMakeLists.txt" "CMakeLists.txt not found in ProjectRoot."

Push-Location $ProjectRoot

# 1) Configure
if (-not (Test-Path $BuildDir)) { New-Item -ItemType Directory -Path $BuildDir | Out-Null }
Write-Host "`n[1/4] CMake configure..." -ForegroundColor Green
cmake -S . -B $BuildDir -G "Visual Studio 17 2022" | Write-Host

# 2) Build
Write-Host "`n[2/4] Build ($Config)..." -ForegroundColor Green
cmake --build $BuildDir --config $Config | Write-Host

# 3) Stage to dist
Write-Host "`n[3/4] Stage files to dist/..." -ForegroundColor Green
$stagingRoot = Join-Path $ProjectRoot "windows_installer_system\dist\DJMikePro"
if (Test-Path $stagingRoot) { Remove-Item $stagingRoot -Recurse -Force }
New-Item -ItemType Directory -Path $stagingRoot | Out-Null

# Expected output path for VS generator:
$exePath = Join-Path $ProjectRoot "$BuildDir\$Config\DJMikePro.exe"
Assert-Path $exePath "Built EXE not found at: $exePath. Adjust exePath in this script if needed."

Copy-Item $exePath $stagingRoot

# OPTIONAL: copy extra runtime assets / DLLs that must sit next to the EXE
# Copy-Item "$ProjectRoot\Assets\*" $stagingRoot -Recurse -Force

# 4) Package with Inno Setup
Write-Host "`n[4/4] Build installer with Inno Setup..." -ForegroundColor Green
Assert-Path $InnoSetupPath "Inno Setup compiler not found: $InnoSetupPath`nInstall Inno Setup 6, or pass -InnoSetupPath."

$iss = Join-Path $ProjectRoot "windows_installer_system\installer\inno\DJMikePro.iss"
Assert-Path $iss "Inno Setup script not found: $iss"

& $InnoSetupPath $iss /DMyAppVersion="$Version" /DMyBuildConfig="$Config" | Write-Host

Write-Host "`nDONE. Installer is in: windows_installer_system\installer\out" -ForegroundColor Cyan
Pop-Location
