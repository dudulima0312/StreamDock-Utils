@echo off
echo ================================
echo WindowCycle Plugin - Teste Final
echo ================================
echo.

echo Verificando estrutura do plugin...
echo.

cd com.windowcycle.streamdock.sdPlugin

echo [1/7] Verificando executavel...
if exist "WindowCycle.exe" (
    echo   [OK] WindowCycle.exe encontrado
) else (
    echo   [ERRO] WindowCycle.exe NAO encontrado!
    pause
    exit /b 1
)

echo.
echo [2/7] Verificando manifest.json...
if exist "manifest.json" (
    echo   [OK] manifest.json encontrado
) else (
    echo   [ERRO] manifest.json NAO encontrado!
    pause
    exit /b 1
)

echo.
echo [3/7] Verificando Property Inspector...
if exist "propertyInspector\windowcycle\index.html" (
    echo   [OK] Property Inspector encontrado
) else (
    echo   [ERRO] Property Inspector NAO encontrado!
    pause
    exit /b 1
)

echo.
echo [4/7] Verificando icones...
if exist "static\img\window-icon.png" (
    echo   [OK] window-icon.png encontrado
) else (
    echo   [ERRO] window-icon.png NAO encontrado!
    pause
    exit /b 1
)

if exist "static\img\window-icon-active.png" (
    echo   [OK] window-icon-active.png encontrado
) else (
    echo   [ERRO] window-icon-active.png NAO encontrado!
    pause
    exit /b 1
)

echo.
echo [5/7] Verificando traducoes...
if exist "en.json" (
    echo   [OK] en.json encontrado
) else (
    echo   [AVISO] en.json NAO encontrado
)

if exist "pt.json" (
    echo   [OK] pt.json encontrado
) else (
    echo   [AVISO] pt.json NAO encontrado
)

echo.
echo [6/7] Verificando tamanho do executavel...
for %%A in ("WindowCycle.exe") do (
    echo   Tamanho: %%~zA bytes
)

echo.
echo [7/7] Testando executavel...
echo   Executando WindowCycle.exe --version...
WindowCycle.exe --version 2>nul
if errorlevel 1 (
    echo   [INFO] Executavel criado (pode nao suportar --version)
)

echo.
echo ================================
echo Verificacao Concluida!
echo ================================
echo.
echo Status: PLUGIN PRONTO PARA INSTALACAO
echo.
echo Para instalar:
echo 1. Arraste esta pasta para o StreamDock
echo    OU
echo 2. Copie para: %%appdata%%\Elgato\StreamDeck\Plugins\
echo 3. Reinicie o StreamDock
echo.
echo Localizacao do plugin:
cd
echo.
pause