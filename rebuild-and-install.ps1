# Script completo: Recompilar e reinstalar WindowCycle
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "WindowCycle - Recompilacao e Instalacao" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$ErrorActionPreference = "Continue"

# 1. Limpar build anterior
Write-Host "[1/6] Limpando build anterior..." -ForegroundColor Yellow
if (Test-Path "dist") {
    Remove-Item -Recurse -Force "dist"
    Write-Host "   Dist removido" -ForegroundColor Green
}
if (Test-Path "build") {
    Remove-Item -Recurse -Force "build"
    Write-Host "   Build removido" -ForegroundColor Green
}
if (Test-Path "WindowCycle.spec") {
    Remove-Item -Force "WindowCycle.spec"
    Write-Host "   Spec removido" -ForegroundColor Green
}

# 2. Recompilar
Write-Host "`n[2/6] Recompilando WindowCycle.exe..." -ForegroundColor Yellow
Write-Host "   Aguarde, isso pode levar alguns minutos..." -ForegroundColor Gray

$compileOutput = & python -m PyInstaller --onefile --windowed --name WindowCycle --add-data "src;src" --hidden-import=pynput --hidden-import=pyautogui main.py 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "   Compilacao concluida!" -ForegroundColor Green
} else {
    Write-Host "   ERRO na compilacao!" -ForegroundColor Red
    Write-Host "   Saida:" -ForegroundColor Gray
    Write-Host $compileOutput
    Read-Host "`nPressione ENTER para sair"
    exit 1
}

# 3. Copiar executavel para plugin
Write-Host "`n[3/6] Copiando executavel para plugin..." -ForegroundColor Yellow
Copy-Item "dist\WindowCycle.exe" "com.windowcycle.streamdock.sdPlugin\" -Force
Write-Host "   Executavel copiado" -ForegroundColor Green

# 4. Verificar tamanho
$size = (Get-Item "com.windowcycle.streamdock.sdPlugin\WindowCycle.exe").Length / 1MB
Write-Host "   Tamanho: $([Math]::Round($size, 1)) MB" -ForegroundColor White

# 5. Reinstalar plugin
Write-Host "`n[4/6] Reinstalando plugin no StreamDock..." -ForegroundColor Yellow
$pluginDir = "$env:APPDATA\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"

if (Test-Path $pluginDir) {
    Remove-Item -Recurse -Force $pluginDir
    Write-Host "   Plugin anterior removido" -ForegroundColor Green
}

Copy-Item -Recurse -Force "com.windowcycle.streamdock.sdPlugin" $pluginDir
Write-Host "   Plugin instalado" -ForegroundColor Green

# 6. Fechar processos antigos
Write-Host "`n[5/6] Fechando processos antigos do WindowCycle..." -ForegroundColor Yellow
$processes = Get-Process -Name "WindowCycle" -ErrorAction SilentlyContinue
if ($processes) {
    $processes | Stop-Process -Force
    Write-Host "   $($processes.Count) processo(s) encerrado(s)" -ForegroundColor Green
} else {
    Write-Host "   Nenhum processo rodando" -ForegroundColor Gray
}

# 7. Reiniciar StreamDock
Write-Host "`n[6/6] Reiniciando StreamDock..." -ForegroundColor Yellow
Stop-Process -Name "Stream Dock AJAZZ Global" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3
Start-Process "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe" -ErrorAction SilentlyContinue
Write-Host "   StreamDock reiniciado" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "CONCLUIDO!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Aguarde alguns segundos e teste o plugin:" -ForegroundColor Yellow
Write-Host "1. Arraste Window Cycle para um knob" -ForegroundColor White
Write-Host "2. Gire o knob" -ForegroundColor White
Write-Host "3. Task View deve abrir!" -ForegroundColor White

Write-Host "`n"
Read-Host "Pressione ENTER para sair"
