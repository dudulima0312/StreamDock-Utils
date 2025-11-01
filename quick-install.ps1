# Quick install script
$ErrorActionPreference = "Stop"

Write-Host "`n[1/4] Verificando executavel..." -ForegroundColor Yellow
if (Test-Path "dist\WindowCycle.exe") {
    $size = (Get-Item "dist\WindowCycle.exe").Length / 1MB
    Write-Host "   OK - Executavel criado: $([Math]::Round($size, 1)) MB" -ForegroundColor Green
} else {
    Write-Host "   ERRO: Executavel nao encontrado!" -ForegroundColor Red
    exit 1
}

Write-Host "`n[2/4] Copiando para plugin..." -ForegroundColor Yellow
Copy-Item "dist\WindowCycle.exe" "com.windowcycle.streamdock.sdPlugin\" -Force
Write-Host "   OK - Copiado" -ForegroundColor Green

Write-Host "`n[3/4] Reinstalando no StreamDock..." -ForegroundColor Yellow
$pluginDir = "$env:APPDATA\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
Copy-Item -Recurse -Force "com.windowcycle.streamdock.sdPlugin\*" $pluginDir -ErrorAction SilentlyContinue
Write-Host "   OK - Plugin reinstalado" -ForegroundColor Green

Write-Host "`n[4/4] Fechando processos antigos e reiniciando StreamDock..." -ForegroundColor Yellow
Get-Process -Name "WindowCycle" -ErrorAction SilentlyContinue | Stop-Process -Force
Stop-Process -Name "Stream Dock AJAZZ Global" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3
Start-Process "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe" -ErrorAction SilentlyContinue
Write-Host "   OK - StreamDock reiniciado" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CONCLUIDO!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nAguarde alguns segundos e teste o plugin!" -ForegroundColor Yellow
