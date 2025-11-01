@echo off
echo ================================
echo WindowCycle - Instalacao Ajazz
echo ================================
echo.

set "PLUGIN_DIR=%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"

echo [1/4] Verificando diretorio de plugins...
if not exist "%APPDATA%\HotSpot\StreamDock\plugins\" (
    echo ERRO: Diretorio de plugins nao encontrado!
    echo Verifique se o StreamDock Ajazz esta instalado.
    pause
    exit /b 1
)
echo   OK - Diretorio encontrado

echo.
echo [2/4] Removendo instalacao anterior (se existir)...
if exist "%PLUGIN_DIR%" (
    rd /s /q "%PLUGIN_DIR%"
    echo   Instalacao anterior removida
) else (
    echo   Nenhuma instalacao anterior encontrada
)

echo.
echo [3/4] Copiando plugin para o StreamDock...
xcopy /E /I /Y "com.windowcycle.streamdock.sdPlugin" "%PLUGIN_DIR%"
if errorlevel 1 (
    echo ERRO: Falha ao copiar plugin!
    pause
    exit /b 1
)
echo   Plugin copiado com sucesso

echo.
echo [4/4] Criando icones sem extensao...
cd "%PLUGIN_DIR%\static\img"
copy /Y window-icon.png window-icon >nul
copy /Y window-icon-active.png window-icon-active >nul
echo   Icones configurados

echo.
echo ================================
echo Instalacao Concluida!
echo ================================
echo.
echo Plugin instalado em:
echo %PLUGIN_DIR%
echo.
echo PROXIMO PASSO:
echo 1. Feche o StreamDock AJAZZ Global
echo 2. Aguarde 3 segundos
echo 3. Abra o StreamDock novamente
echo 4. Procure por "Window Cycle" nas acoes
echo.
echo Deseja reiniciar o StreamDock agora? (S/N)
choice /C SN /N /M "Pressione S para SIM ou N para NAO: "
if errorlevel 2 goto :end
if errorlevel 1 goto :restart

:restart
echo.
echo Reiniciando StreamDock...
taskkill /F /IM "Stream Dock AJAZZ Global.exe" 2>nul
timeout /t 3 /nobreak >nul
start "" "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe"
echo.
echo StreamDock reiniciado!
echo Aguarde alguns segundos para ele inicializar completamente.

:end
echo.
echo Veja INSTALL-AJAZZ.md para mais informacoes.
echo.
pause