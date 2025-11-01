@echo off
echo Fechando StreamDock...
taskkill /F /IM "Stream Dock AJAZZ Global.exe" 2>nul
timeout /t 3 /nobreak
echo.
echo Procurando executavel do StreamDock...

if exist "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe" (
    echo Encontrado! Iniciando...
    start "" "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe"
    echo StreamDock reiniciado!
) else if exist "C:\Program Files\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe" (
    echo Encontrado! Iniciando...
    start "" "C:\Program Files\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe"
    echo StreamDock reiniciado!
) else (
    echo ERRO: Nao consegui encontrar o executavel do StreamDock!
    echo Inicie manualmente o Stream Dock AJAZZ Global
)

echo.
echo ========================================
echo Plugin instalado com as correcoes!
echo ========================================
echo.
echo Agora teste o plugin "Window Cycle":
echo 1. Arraste para um knob ou botao
echo 2. Gire o knob ou clique no botao
echo 3. Deve abrir o Task View e navegar
echo.
pause
