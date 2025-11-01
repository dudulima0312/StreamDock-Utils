# Check WindowCycle status
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "WindowCycle - Status Atual" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$proc = Get-Process -Name 'WindowCycle' -ErrorAction SilentlyContinue
if ($proc) {
    Write-Host "[OK] WindowCycle.exe ESTA RODANDO!" -ForegroundColor Green
    foreach ($p in $proc) {
        Write-Host "   PID: $($p.Id)" -ForegroundColor White
        $size = $p.WorkingSet64 / 1MB
        Write-Host "   Memoria: $([Math]::Round($size, 1)) MB" -ForegroundColor White
    }
} else {
    Write-Host "[AVISO] WindowCycle.exe NAO esta rodando" -ForegroundColor Yellow
    Write-Host "   Aguarde alguns segundos ou gire o knob para iniciar" -ForegroundColor Gray
}

Write-Host "`nVerificando logs..." -ForegroundColor Yellow
$logFile = "$env:APPDATA\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\logs\plugin.log"
if (Test-Path $logFile) {
    Write-Host "Ultimas 10 linhas do log:" -ForegroundColor Cyan
    Write-Host "----------------------------------------" -ForegroundColor Gray
    Get-Content $logFile -Tail 10 | ForEach-Object {
        if ($_ -match "Keyboard controller not available") {
            Write-Host $_ -ForegroundColor Red
        } elseif ($_ -match "Opening Task View|Navigating") {
            Write-Host $_ -ForegroundColor Green
        } elseif ($_ -match "ERROR") {
            Write-Host $_ -ForegroundColor Red
        } elseif ($_ -match "Dial rotated") {
            Write-Host $_ -ForegroundColor Cyan
        } else {
            Write-Host $_ -ForegroundColor White
        }
    }
    Write-Host "----------------------------------------" -ForegroundColor Gray
} else {
    Write-Host "Log ainda nao foi criado" -ForegroundColor Yellow
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "PROXIMO PASSO:" -ForegroundColor Yellow
Write-Host "GIRE O KNOB e veja se Task View abre!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan
