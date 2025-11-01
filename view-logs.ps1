# Visualizar logs do WindowCycle em tempo real
$pluginPath = "$env:APPDATA\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
$logFile = "$pluginPath\logs\plugin.log"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "WindowCycle - Visualizador de Logs" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

if (Test-Path $logFile) {
    Write-Host "Log encontrado: $logFile`n" -ForegroundColor Green
    Write-Host "Ultimas 50 linhas:" -ForegroundColor Yellow
    Write-Host "----------------------------------------`n" -ForegroundColor Gray

    Get-Content $logFile -Tail 50 | ForEach-Object {
        if ($_ -match "ERROR") {
            Write-Host $_ -ForegroundColor Red
        } elseif ($_ -match "WARNING") {
            Write-Host $_ -ForegroundColor Yellow
        } elseif ($_ -match "INFO") {
            Write-Host $_ -ForegroundColor White
        } elseif ($_ -match "DEBUG") {
            Write-Host $_ -ForegroundColor Gray
        } elseif ($_ -match "Dial rotated") {
            Write-Host $_ -ForegroundColor Cyan
        } elseif ($_ -match "Task View") {
            Write-Host $_ -ForegroundColor Green
        } else {
            Write-Host $_ -ForegroundColor White
        }
    }

    Write-Host "`n----------------------------------------" -ForegroundColor Gray
    Write-Host "`nProcure por:" -ForegroundColor Yellow
    Write-Host "- 'Dial rotated' = Knob foi girado" -ForegroundColor Cyan
    Write-Host "- 'Opening Task View' = Task View abrindo" -ForegroundColor Green
    Write-Host "- 'ERROR' = Erros" -ForegroundColor Red

} else {
    Write-Host "Log NAO encontrado em: $logFile" -ForegroundColor Red
    Write-Host "`nPossíveis localizacoes:" -ForegroundColor Yellow
    Write-Host "1. $pluginPath\logs\plugin.log" -ForegroundColor White
    Write-Host "2. $pluginPath\plugin.log" -ForegroundColor White

    Write-Host "`nProcurando logs..." -ForegroundColor Yellow
    Get-ChildItem -Path $pluginPath -Filter "*.log" -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "Encontrado: $($_.FullName)" -ForegroundColor Green
    }
}

Write-Host "`n"
Read-Host "Pressione ENTER para sair"
