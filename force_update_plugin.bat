@echo off
echo ========================================
echo Force Update WindowCycle Plugin
echo ========================================
echo.

echo [1/4] Matando processo do StreamDock...
taskkill /F /IM "Stream Dock AJAZZ.exe" 2>nul
if %errorlevel% equ 0 (
    echo StreamDock fechado!
) else (
    echo StreamDock ja estava fechado.
)
timeout /t 2 >nul

echo.
echo [2/4] Copiando dist\WindowCycle.exe para plugin source...
copy /Y "d:\Projetos\Space Plugin\WindowCycle-Dev\dist\WindowCycle.exe" "d:\Projetos\Space Plugin\WindowCycle-Dev\com.windowcycle.streamdock.sdPlugin\WindowCycle.exe"

echo.
echo [3/4] Copiando para instalacao do StreamDock...
copy /Y "d:\Projetos\Space Plugin\WindowCycle-Dev\dist\WindowCycle.exe" "C:\Users\Dudu Lima\AppData\Roaming\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\WindowCycle.exe"

if %errorlevel% equ 0 (
    echo.
    echo [4/4] Exe copiado com sucesso!
    echo.
    echo ========================================
    echo PRONTO! Agora abra o StreamDock.
    echo ========================================
) else (
    echo.
    echo [4/4] ERRO ao copiar exe!
    echo ========================================
)
echo.
pause
