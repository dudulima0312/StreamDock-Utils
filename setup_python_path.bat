@echo off
echo ================================
echo Configurando Python no PATH
echo ================================
echo.

REM Adicionar Python e Scripts ao PATH do usuário
set "PYTHON_PATH=C:\Users\Dudu Lima\AppData\Local\Programs\Python\Python313"
set "PYTHON_SCRIPTS=%PYTHON_PATH%\Scripts"

echo Adicionando ao PATH:
echo - %PYTHON_PATH%
echo - %PYTHON_SCRIPTS%
echo.

REM Adicionar ao PATH do usuário permanentemente
setx PATH "%PATH%;%PYTHON_PATH%;%PYTHON_SCRIPTS%"

REM Adicionar temporariamente para esta sessão
set "PATH=%PATH%;%PYTHON_PATH%;%PYTHON_SCRIPTS%"

echo.
echo PATH atualizado com sucesso!
echo.
echo Testando Python...
python --version
echo.
echo Testando pip...
pip --version
echo.
pause