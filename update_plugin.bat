@echo off
echo Copiando dist\WindowCycle.exe para plugin...
copy /Y "d:\Projetos\Space Plugin\WindowCycle-Dev\dist\WindowCycle.exe" "d:\Projetos\Space Plugin\WindowCycle-Dev\com.windowcycle.streamdock.sdPlugin\WindowCycle.exe"
echo.
echo Copiando para instalacao do StreamDock...
copy /Y "d:\Projetos\Space Plugin\WindowCycle-Dev\dist\WindowCycle.exe" "C:\Users\Dudu Lima\AppData\Roaming\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\WindowCycle.exe"
if %errorlevel% equ 0 (
    echo Exe copiado com sucesso!
) else (
    echo ERRO ao copiar exe! Certifique-se que o StreamDock esta fechado.
)
pause
