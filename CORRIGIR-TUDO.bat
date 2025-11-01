@echo off
echo ================================================
echo WindowCycle - CORRECAO COMPLETA
echo ================================================
echo.
echo Este script vai:
echo 1. Recompilar o WindowCycle.exe (COM pynput incluido)
echo 2. Reinstalar no StreamDock Ajazz
echo 3. Reiniciar o StreamDock
echo.
echo Aguarde, pode levar alguns minutos...
echo.
pause

REM Limpar builds anteriores
echo [1/5] Limpando builds anteriores...
if exist dist rd /s /q dist
if exist build rd /s /q build
if exist WindowCycle.spec del /f /q WindowCycle.spec
echo    OK

REM Recompilar COM hidden-imports
echo.
echo [2/5] Recompilando COM pynput incluido...
echo    Isso pode levar 2-3 minutos...
pyinstaller --onefile --windowed --name WindowCycle --add-data "src;src" --hidden-import=pynput --hidden-import=pynput.keyboard --hidden-import=pynput.keyboard._win32 --hidden-import=pynput.mouse --hidden-import=pyautogui main.py

if not exist dist\WindowCycle.exe (
    echo    ERRO: Compilacao falhou!
    pause
    exit /b 1
)
echo    OK - Executavel criado

REM Copiar para plugin
echo.
echo [3/5] Copiando para plugin...
copy /Y dist\WindowCycle.exe com.windowcycle.streamdock.sdPlugin\
echo    OK

REM Reinstalar
echo.
echo [4/5] Reinstalando no StreamDock...
set "PLUGIN_DIR=%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
if exist "%PLUGIN_DIR%" rd /s /q "%PLUGIN_DIR%"
xcopy /E /I /Y com.windowcycle.streamdock.sdPlugin "%PLUGIN_DIR%"
echo    OK

REM Fechar processos antigos
echo.
echo [5/5] Fechando processos antigos...
taskkill /F /IM WindowCycle.exe 2>nul
echo    OK

REM Reiniciar StreamDock
echo.
echo Reiniciando StreamDock...
taskkill /F /IM "Stream Dock AJAZZ Global.exe" 2>nul
timeout /t 3 /nobreak >nul
start "" "C:\Program Files (x86)\Stream Dock AJAZZ Global\Stream Dock AJAZZ Global.exe"

echo.
echo ================================================
echo CONCLUIDO!
echo ================================================
echo.
echo Aguarde o StreamDock inicializar e teste:
echo 1. Arraste "Window Cycle" para um knob
echo 2. Gire o knob
echo 3. Task View deve abrir!
echo.
echo Para verificar os logs:
echo    view-logs.ps1
echo.
pause
