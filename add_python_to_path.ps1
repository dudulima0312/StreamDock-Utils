# Script para adicionar Python ao PATH do Windows
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Configurando Python no PATH" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

$pythonPath = "C:\Users\Dudu Lima\AppData\Local\Programs\Python\Python313"
$pythonScripts = "$pythonPath\Scripts"

# Verificar se os diretórios existem
if (Test-Path $pythonPath) {
    Write-Host "Python encontrado em: $pythonPath" -ForegroundColor Green
} else {
    Write-Host "Python NÃO encontrado em: $pythonPath" -ForegroundColor Red
    exit 1
}

# Obter PATH atual do usuário
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Verificar se já está no PATH
if ($currentPath -notlike "*$pythonPath*") {
    Write-Host "Adicionando Python ao PATH..." -ForegroundColor Yellow

    # Adicionar ao PATH do usuário
    $newPath = "$currentPath;$pythonPath;$pythonScripts"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")

    Write-Host "Python adicionado ao PATH com sucesso!" -ForegroundColor Green

    # Atualizar PATH da sessão atual
    $env:Path = "$env:Path;$pythonPath;$pythonScripts"
} else {
    Write-Host "Python já está no PATH!" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Testando instalação..." -ForegroundColor Cyan
Write-Host ""

# Testar Python
Write-Host "Python Version:" -ForegroundColor Yellow
& "$pythonPath\python.exe" --version

Write-Host ""
Write-Host "Pip Version:" -ForegroundColor Yellow
& "$pythonPath\Scripts\pip.exe" --version

Write-Host ""
Write-Host "PyInstaller:" -ForegroundColor Yellow
& "$pythonPath\Scripts\pyinstaller.exe" --version

Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Configuração concluída!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "IMPORTANTE: Para que as mudanças tenham efeito completo," -ForegroundColor Yellow
Write-Host "feche e reabra o terminal ou IDE." -ForegroundColor Yellow