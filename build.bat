@echo off
echo ================================
echo WindowCycle Plugin Builder
echo ================================
echo.

echo Preparando para compilar o plugin WindowCycle...
echo.

REM Verificar se Python está instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Python não encontrado!
    echo Por favor, instale Python 3.8 ou superior
    pause
    exit /b 1
)

echo [1/4] Instalando dependências...
pip install -r requirements.txt
if errorlevel 1 (
    echo ERRO: Falha ao instalar dependências
    echo Tente: pip install pyinstaller pynput pyautogui Pillow websocket-client requests
    pause
    exit /b 1
)

echo.
echo [2/4] Criando executável com PyInstaller (com pynput incluído)...
pyinstaller --onefile --windowed --name WindowCycle --add-data "src;src" --hidden-import=pynput --hidden-import=pynput.keyboard --hidden-import=pynput.keyboard._win32 --hidden-import=pynput.mouse --hidden-import=pyautogui main.py
if errorlevel 1 (
    echo ERRO: Falha ao criar executável
    pause
    exit /b 1
)

echo.
echo [3/4] Copiando arquivos para o plugin...
if not exist "com.windowcycle.streamdock.sdPlugin" mkdir "com.windowcycle.streamdock.sdPlugin"

copy dist\WindowCycle.exe com.windowcycle.streamdock.sdPlugin\
copy manifest.json com.windowcycle.streamdock.sdPlugin\
xcopy /E /I /Y propertyInspector com.windowcycle.streamdock.sdPlugin\propertyInspector
xcopy /E /I /Y static com.windowcycle.streamdock.sdPlugin\static

echo.
echo [4/4] Criando arquivos de tradução...
echo {"Name": "Window Cycle", "Description": "Cycle through open windows"} > com.windowcycle.streamdock.sdPlugin\en.json
echo {"Name": "窗口循环", "Description": "循环切换打开的窗口"} > com.windowcycle.streamdock.sdPlugin\zh_CN.json

echo.
echo ================================
echo Compilação concluída!
echo ================================
echo.
echo Plugin criado em: com.windowcycle.streamdock.sdPlugin\
echo.
echo Para instalar no StreamDock:
echo 1. Abra o StreamDock
echo 2. Vá em Configurações - Plugins
echo 3. Clique em "Instalar Plugin"
echo 4. Selecione a pasta "com.windowcycle.streamdock.sdPlugin"
echo.
pause