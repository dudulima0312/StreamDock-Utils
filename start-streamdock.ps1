$proc = Get-Process | Where-Object { $_.ProcessName -like "*Stream Dock*" }
if ($proc) {
    Write-Host "StreamDock JA esta rodando!" -ForegroundColor Green
} else {
    Write-Host "Tentando iniciar StreamDock..." -ForegroundColor Yellow

    # Tentar varios caminhos possiveis
    $paths = @(
        "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe",
        "C:\Program Files\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe"
    )

    foreach ($path in $paths) {
        if (Test-Path $path) {
            Write-Host "Encontrado em: $path" -ForegroundColor Green
            Start-Process $path
            Start-Sleep -Seconds 5
            Write-Host "StreamDock iniciado!" -ForegroundColor Green
            break
        }
    }
}

Write-Host "`nAguardando mais 5 segundos para garantir inicializacao..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
Write-Host "Pronto!" -ForegroundColor Green
