@echo off
echo ================================
echo Teste do WindowCycle.exe
echo ================================
echo.

cd "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"

echo Testando se o executavel existe...
if not exist WindowCycle.exe (
    echo ERRO: WindowCycle.exe nao encontrado!
    pause
    exit /b 1
)
echo OK - Executavel encontrado
echo.

echo Testando se o executavel roda sem parametros (deve dar erro)...
WindowCycle.exe
echo.

echo ================================
echo Se aparecer erro de parametros faltando, esta correto!
echo Isso significa que o executavel funciona, mas o StreamDock
echo nao esta passando os parametros necessarios.
echo ================================
pause
