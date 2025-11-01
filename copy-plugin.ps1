$pluginDir = Join-Path $env:APPDATA "HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
$sourceDir = "com.windowcycle.streamdock.sdPlugin"

Write-Host "Copiando de: $sourceDir" -ForegroundColor Yellow
Write-Host "Para: $pluginDir" -ForegroundColor Yellow

Get-ChildItem -Path $sourceDir -Recurse | ForEach-Object {
    $dest = $_.FullName.Replace($sourceDir, $pluginDir)
    if ($_.PSIsContainer) {
        if (!(Test-Path $dest)) {
            New-Item -ItemType Directory -Path $dest -Force | Out-Null
        }
    } else {
        Copy-Item $_.FullName -Destination $dest -Force
    }
}

Write-Host "Plugin copiado com sucesso!" -ForegroundColor Green
