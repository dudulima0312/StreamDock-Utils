# Reinstall WindowCycle with fixed manifest
$pluginDir = "$env:APPDATA\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
$sourceDir = "d:\Projetos\Space Plugin\WindowCycle-Dev\com.windowcycle.streamdock.sdPlugin"

Write-Host "Removing old installation..." -ForegroundColor Yellow
if (Test-Path $pluginDir) {
    Remove-Item -Path $pluginDir -Recurse -Force
    Write-Host "Old installation removed" -ForegroundColor Green
}

Write-Host "`nCopying plugin with fixed manifest..." -ForegroundColor Yellow
Copy-Item -Path $sourceDir -Destination $pluginDir -Recurse -Force
Write-Host "Plugin copied successfully" -ForegroundColor Green

Write-Host "`nVerifying manifest.json..." -ForegroundColor Yellow
$manifestPath = Join-Path $pluginDir "manifest.json"
if (Test-Path $manifestPath) {
    $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
    if ($manifest.CodePath) {
        Write-Host "CodePath found: $($manifest.CodePath)" -ForegroundColor Green
    } else {
        Write-Host "ERROR: CodePath not found in manifest!" -ForegroundColor Red
    }
}

Write-Host "`nVerifying executable..." -ForegroundColor Yellow
$exePath = Join-Path $pluginDir "WindowCycle.exe"
if (Test-Path $exePath) {
    $size = (Get-Item $exePath).Length / 1MB
    Write-Host "WindowCycle.exe found ($([Math]::Round($size, 1)) MB)" -ForegroundColor Green
} else {
    Write-Host "ERROR: WindowCycle.exe not found!" -ForegroundColor Red
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nNow restart StreamDock:" -ForegroundColor Yellow
Write-Host "1. Close Stream Dock AJAZZ Global" -ForegroundColor White
Write-Host "2. Wait 3 seconds" -ForegroundColor White
Write-Host "3. Open Stream Dock AJAZZ Global again" -ForegroundColor White
Write-Host "`nOr run: .\restart-streamdock-ajazz.bat" -ForegroundColor Cyan
