::CABECALHO
::---------
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

::VARIAVEIS
::---------
rem Caminhos
@set UNIDADE=Z:
@set PATH_CTEMP=C:\TEMP
@set PATH_BASES=%UNIDADE%\BASES
call:getPath 2
set IMP_NOME=!getPath_return!
set FILE_IMP_TS_ATUAL=TS_ATUAL.INI
set PATH_IMP_TS_ATUAL=%PATH_BASES%\!getPath_return!\%FILE_IMP_TS_ATUAL%
set /p VAR_TS_ATUAL=<!PATH_IMP_TS_ATUAL!
set PATH_IMPORTACAO=%PATH_BASES%\!getPath_return!\!VAR_TS_ATUAL!
set PATH_WORKSPACE=!PATH_IMPORTACAO!\DESTINO
rem Arquivos
@set FILE_FDB=!PATH_WORKSPACE!\DADOS.FDB
@set FILE_ZIP_CLIENTE=DADOS_CLIENTE.ZIP
@set FILE_ZIP_FORNECEDOR=DADOS_FORNECEDOR.ZIP
@set FILE_ZIP_TRANSPORTADORA=DADOS_TRANSPORTADORA.ZIP
@set FILE_ZIP_PRODUTO=DADOS_PRODUTO.ZIP
@set FILE_ZIP_ESTOQUE=DADOS_ESTOQUE.ZIP
@set FILE_ZIP_FINAL=DADOS_FINAL.ZIP
rem Aplicativos
@set EXE_7ZIP=%ProgramFiles%\7-Zip\7z.exe
@set EXE_GBAK=%ProgramFiles%\Firebird\Firebird_3_0\gbak.exe
rem Ambiente
@set USER=sysdba
@set SENHA=masterkey
rem Mensagem
@set MSG_OK=Backup realizado
@set MSG_ERRORDEFAULT=Não foi possível fazer o backup
@set MSG_ERRO=Erro inesperado
@set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
@set MSG_INICIAL=Iniciando backup da entidade

:::MAIN
:::----------------------------------------------------------------------
@if %COMPUTERNAME% EQU DESKTOP-4A54RRC (
	@echo.
	@echo %MSG_INICIAL%...
	if not exist "%PATH_WORKSPACE%\%FILE_ZIP_CLIENTE%" goto:BACKUP_CLIENTE
	if not exist "%PATH_WORKSPACE%\%FILE_ZIP_FORNECEDOR%" goto:BACKUP_FORNECEDOR
	if not exist "%PATH_WORKSPACE%\%FILE_ZIP_TRANSPORTADORA%" goto:BACKUP_TRANPORTADORA
	if not exist "%PATH_WORKSPACE%\%FILE_ZIP_PRODUTO%" goto:BACKUP_PRODUTO
	if not exist "%PATH_WORKSPACE%\%FILE_ZIP_ESTOQUE%" goto:BACKUP_ESTOQUE
	if not exist "%PATH_WORKSPACE%\%FILE_ZIP_FINAL%" goto:BACKUP_FINAL
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
goto:end

:BACKUP_CLIENTE
@set VAR_ENTIDADE=CLIENTE
call:FazBackup VAR_ENTIDADE
goto:exit
:BACKUP_FORNECEDOR
@set VAR_ENTIDADE=FORNECEDOR
call:FazBackup VAR_ENTIDADE
goto:exit
:BACKUP_TRANPORTADORA
@set VAR_ENTIDADE=TRANSPORTADORA
call:FazBackup VAR_ENTIDADE
goto:exit
:BACKUP_PRODUTO
@set VAR_ENTIDADE=PRODUTO
call:FazBackup VAR_ENTIDADE
goto:exit
:BACKUP_ESTOQUE
@set VAR_ENTIDADE=ESTOQUE
call:FazBackup VAR_ENTIDADE
goto:exit
:BACKUP_FINAL
@set VAR_ENTIDADE=FINAL
call:FazBackup VAR_ENTIDADE
goto:exit

:FazBackup Entidade
@set FILE_FDB_TEMP=%PATH_CTEMP%\DADOS_!%~1!.FDB
@set FILE_BCK_TEMP=%PATH_CTEMP%\DADOS_!%~1!.BCK
@set FILE_ZIP_TEMP=%PATH_CTEMP%\DADOS_!%~1!.ZIP
@set FILE_ZIP_DESTINO=%PATH_WORKSPACE%\DADOS_!%~1!.ZIP
call:LimpaTemp
@copy "%FILE_FDB%" "%FILE_FDB_TEMP%" /y >nul
@echo - Gbaking !%~1!.FDB...
	@"%EXE_GBAK%" -b -user %USER% -pass %SENHA% "%FILE_FDB_TEMP%" "%FILE_BCK_TEMP%"
	if %ERRORLEVEL% NEQ 0 goto:ERROR
@echo - 7ziping !%~1!.ZIP...
	@"%EXE_7ZIP%" a -tzip "%FILE_ZIP_TEMP%" "%FILE_BCK_TEMP%" -y -sdel >nul
	if %ERRORLEVEL% NEQ 0 goto:ERROR
@echo - Copying to "%FILE_ZIP_DESTINO%"...
	@copy "%FILE_ZIP_TEMP%" "%FILE_ZIP_DESTINO%" /y >nul
	if %ERRORLEVEL% NEQ 0 goto:ERROR
call:LimpaTemp
goto:eof

:LimpaTemp
if exist !FILE_FDB_TEMP! del !FILE_FDB_TEMP! >nul
if exist !FILE_BCK_TEMP! del !FILE_BCK_TEMP! >nul
if exist !FILE_ZIP_TEMP! del !FILE_ZIP_TEMP! >nul
goto:eof

:DataAmericano
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
set HOJE=%ANO%.%MES%.%DIA%
goto:eof

:getPath
SETLOCAL
for /f "tokens=1,2,3,4 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"
( ENDLOCAL
	IF %~1 == 1 SET getPath_return=%PASTA_ATUAL[1]%
	IF %~1 == 2 SET getPath_return=%PASTA_ATUAL[2]%
	IF %~1 == 3 SET getPath_return=%PASTA_ATUAL[3]%
	IF %~1 == 4 SET getPath_return=%PASTA_ATUAL[4]%
)
goto:eof

::SAIDAS
::---------
:EXIT
echo.&echo Base %VAR_ENTIDADE% criada&timeout 10>nul&goto:END
goto:end

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END