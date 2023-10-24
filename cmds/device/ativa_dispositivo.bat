@echo off
chcp 1252 > nul
echo Executando com privilégios de administrador...
echo.

runas /user:Administrador "python ativa_dispositivo.py"

echo.
echo Script Python concluído.
pause
