@echo off
chcp 1252 > nul
echo Executando com privil�gios de administrador...
echo.

runas /user:Administrador "python ativa_dispositivo.py"

echo.
echo Script Python conclu�do.
pause
