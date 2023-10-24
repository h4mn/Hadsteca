:: Script para fazer backup e restaure utilizando o gbak
:: Variaveis de ambiente
@echo off
set PATH=%PATH%;C:\Program Files\Firebird\Firebird_4_0

:: Variaveis de backup
set BKP_DIR=D:\_hads\_tarefas
set BKP_FILE=backup.bck
set BKP_USER=SYSDBA
set BKP_PASS=sbofutura
set BKP_IP=serverimport
set BKP_PORT=3050
set BKP_DB=trunk.fdb

:: Variaveis de restore
set RST_DIR=D:\_hads\_tarefas
set RST_FILE=backup.bck
set RST_USER=SYSDBA
set RST_PASS=sbofutura
set RST_IP=serverimport
set RST_PORT=3050
set RST_DB=trunk.fdb

:: Fazer um choice para o usuario escolher o que fazer
choice /c:br /m "Escolha uma opcao: (B)ackup ou (R)estore"

:: Se o usuario escolher B, entao faz o backup
if errorlevel 2 goto restore

:: Se o usuario escolher R, entao faz o restore
if errorlevel 1 goto backup

:backup
echo Fazendo backup...
gbak -b -v -user %BKP_USER% -pass %BKP_PASS% %BKP_IP%:%BKP_PORT% %BKP_DIR%\%BKP_DB% %BKP_DIR%\%BKP_FILE%
goto saida

:restore
echo Fazendo restore...
gbak -c -v -user %RST_USER% -pass %RST_PASS% %RST_DIR%\%RST_FILE% %RST_IP%:%RST_PORT% %RST_DIR%\%RST_DB%

:: Fim do script
:saida
echo Fim do script
pause
```