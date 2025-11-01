@echo off
echo ================================
echo Reiniciando Ajazz StreamDock
echo ================================
echo.

echo [1/3] Fechando StreamDock...
taskkill /F /IM "Stream Dock AJAZZ Global.exe" 2>nul
if errorlevel 1 (
    echo   StreamDock nao estava rodando
) else (
    echo   StreamDock fechado com sucesso
)

echo.
echo Aguardando 3 segundos...
timeout /t 3 /nobreak >nul

echo.
echo [2/3] Iniciando StreamDock...
start "" "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe"

echo.
echo [3/3] Aguardando StreamDock inicializar...
timeout /t 5 /nobreak >nul

echo.
echo ================================
echo StreamDock reiniciado!
echo ================================
echo.
echo Verifique se o plugin "Window Cycle" aparece agora
echo.
echo Se nao aparecer:
echo 1. Verifique se o plugin esta em:
echo    C:\Program Files (x86)\Stream Dock AJAZZ Global\plugins\com.windowcycle.streamdock.sdPlugin
echo.
echo 2. Verifique os logs em:
echo    %%APPDATA%%\HotSpot\StreamDock\logs\
echo.
pause