@echo off
echo ========================================
echo INSTALADOR - Window Cycle Plugin
echo ========================================
echo.

REM Encontrar o diretório de instalação do StreamDock
set "STREAMDOCK_DIR=%APPDATA%\HotSpot\StreamDock"

if not exist "%STREAMDOCK_DIR%" (
    echo ERRO: StreamDock nao encontrado!
    echo Esperado em: %STREAMDOCK_DIR%
    pause
    exit /b 1
)

echo StreamDock encontrado: %STREAMDOCK_DIR%
echo.

REM Verificar se o StreamDock está rodando
tasklist /FI "IMAGENAME eq StreamDock.exe" 2>NUL | find /I /N "StreamDock.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo ========================================
    echo AVISO: StreamDock esta rodando!
    echo FECHE o StreamDock antes de continuar!
    echo ========================================
    pause
    taskkill /F /IM WindowCycle.exe >NUL 2>&1
    timeout /t 2 >NUL
)

REM Remover plugin antigo
set "PLUGIN_DIR=%STREAMDOCK_DIR%\plugins\com.windowcycle.streamdock.sdPlugin"
if exist "%PLUGIN_DIR%" (
    echo Removendo plugin antigo...
    rmdir /s /q "%PLUGIN_DIR%" 2>NUL
    if exist "%PLUGIN_DIR%" (
        echo ERRO: Nao foi possivel remover plugin antigo!
        echo Feche o StreamDock completamente e tente novamente.
        pause
        exit /b 1
    )
)

REM Copiar novo plugin (TODA a estrutura)
echo.
echo Copiando plugin atualizado...
xcopy /s /i /y "com.windowcycle.streamdock.sdPlugin" "%PLUGIN_DIR%\"

if not exist "%PLUGIN_DIR%\manifest.json" (
    echo ERRO: Instalacao falhou!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Plugin instalado com sucesso!
echo.
echo Arquivos copiados:
dir "%PLUGIN_DIR%" /b
echo.
echo Agora abra o StreamDock!
echo ========================================
pause
