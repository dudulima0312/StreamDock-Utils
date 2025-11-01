# Script para verificar se WindowCycle.exe está rodando e depuração
Write-Host "========================" -ForegroundColor Cyan
Write-Host "WindowCycle Diagnóstico" -ForegroundColor Cyan
Write-Host "========================`n" -ForegroundColor Cyan

$pluginPath = "$env:APPDATA\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"

Write-Host "1. Verificando executável..." -ForegroundColor Yellow
if (Test-Path "$pluginPath\WindowCycle.exe") {
    $size = (Get-Item "$pluginPath\WindowCycle.exe").Length / 1MB
    Write-Host "   OK - WindowCycle.exe encontrado ($([Math]::Round($size, 1)) MB)" -ForegroundColor Green
} else {
    Write-Host "   ERRO - WindowCycle.exe NÃO encontrado!" -ForegroundColor Red
    exit
}

Write-Host "`n2. Verificando se WindowCycle.exe está rodando..." -ForegroundColor Yellow
$process = Get-Process -Name "WindowCycle" -ErrorAction SilentlyContinue
if ($process) {
    Write-Host "   ENCONTRADO! WindowCycle.exe está rodando:" -ForegroundColor Green
    Write-Host "   PID: $($process.Id)" -ForegroundColor White
    Write-Host "   Memória: $([Math]::Round($process.WorkingSet / 1MB, 1)) MB" -ForegroundColor White
    Write-Host "   Tempo: $($process.StartTime)" -ForegroundColor White
} else {
    Write-Host "   NÃO ENCONTRADO! WindowCycle.exe não está rodando" -ForegroundColor Red
    Write-Host "   Isso significa que o StreamDock não está iniciando o plugin!" -ForegroundColor Yellow
}

Write-Host "`n3. Testando executável manualmente (deve dar erro de parâmetros)..." -ForegroundColor Yellow
Write-Host "   Aguarde..." -ForegroundColor Gray

# Tentar executar sem parâmetros (deve dar erro)
$output = & "$pluginPath\WindowCycle.exe" 2>&1 | Out-String

if ($output -match "required" -or $output -match "argument" -or $output -match "port") {
    Write-Host "   OK - Executável funciona! Erro esperado de parâmetros:" -ForegroundColor Green
    Write-Host "   $($output.Substring(0, [Math]::Min(200, $output.Length)))" -ForegroundColor Gray
} else {
    Write-Host "   Saída inesperada:" -ForegroundColor Yellow
    Write-Host "   $output" -ForegroundColor Gray
}

Write-Host "`n4. Verificando manifest.json..." -ForegroundColor Yellow
$manifest = Get-Content "$pluginPath\manifest.json" -Raw | ConvertFrom-Json
if ($manifest.CodePath) {
    Write-Host "   OK - CodePath: $($manifest.CodePath)" -ForegroundColor Green
} else {
    Write-Host "   ERRO - CodePath não encontrado!" -ForegroundColor Red
}

Write-Host "`n========================" -ForegroundColor Cyan
Write-Host "CONCLUSÃO:" -ForegroundColor Cyan
Write-Host "========================`n" -ForegroundColor Cyan

if (-not $process) {
    Write-Host "PROBLEMA: O StreamDock não está iniciando o WindowCycle.exe!" -ForegroundColor Red
    Write-Host "`nPossíveis causas:" -ForegroundColor Yellow
    Write-Host "1. StreamDock precisa de reinício completo" -ForegroundColor White
    Write-Host "2. Formato do manifest.json incompatível com Ajazz" -ForegroundColor White
    Write-Host "3. Permissões insuficientes" -ForegroundColor White
    Write-Host "4. Python dependencies não encontradas pelo exe" -ForegroundColor White
    Write-Host "`nSoluções:" -ForegroundColor Yellow
    Write-Host "1. Feche COMPLETAMENTE o StreamDock (Task Manager se necessário)" -ForegroundColor White
    Write-Host "2. Aguarde 5 segundos" -ForegroundColor White
    Write-Host "3. Execute StreamDock como Administrador" -ForegroundColor White
    Write-Host "4. Teste o plugin novamente" -ForegroundColor White
} else {
    Write-Host "OK! O plugin está rodando. Se não funciona, o problema é na lógica." -ForegroundColor Green
}

Write-Host "`n" -ForegroundColor White
Read-Host "Pressione ENTER para sair"
