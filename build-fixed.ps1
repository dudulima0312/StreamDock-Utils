# Build with ALL pynput modules collected
Write-Host "Limpando build anterior..." -ForegroundColor Yellow
Remove-Item -Recurse -Force dist -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force build -ErrorAction SilentlyContinue
Remove-Item -Force WindowCycle.spec -ErrorAction SilentlyContinue

Write-Host "`nCompilando COM --collect-all para garantir inclusao..." -ForegroundColor Yellow

& "C:\Users\Dudu Lima\AppData\Local\Programs\Python\Python313\python.exe" -m PyInstaller `
    --onefile `
    --windowed `
    --name WindowCycle `
    --add-data "src;src" `
    --collect-all pynput `
    --collect-all pyautogui `
    --hidden-import=pynput `
    --hidden-import=pynput.keyboard `
    --hidden-import=pynput.keyboard._win32 `
    --hidden-import=pynput.mouse `
    --hidden-import=pyautogui `
    main.py

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nCompilacao OK!" -ForegroundColor Green
    $size = (Get-Item "dist\WindowCycle.exe").Length / 1MB
    Write-Host "Tamanho: $([Math]::Round($size, 1)) MB" -ForegroundColor White
} else {
    Write-Host "`nErro na compilacao!" -ForegroundColor Red
}
