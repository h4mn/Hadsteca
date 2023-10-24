@echo off
@cls
@chcp 1252 >nul
set PATH_DEV=Z:\DEV
set PATH_BASES=Z:\BASES
set PATH_CTEMP=C:\TEMP
set EXE_ISQL=C:\Program Files\Firebird\Firebird_3_0\isql.exe
set VAR_USER=SYSDBA
set VAR_PASSWORD=masterkey
call:getPath 2
set PATH_IMPORTACAO=%PATH_BASES%\%getPath_return%
call:getPath 3
set PATH_WORKSPACE=%PATH_IMPORTACAO%\%getPath_return%
echo 2 %PATH_IMPORTACAO%
echo 3 %PATH_WORKSPACE%
set FILE_OUTPUT=ESTATISTICAS_ORIGEM.LOG
set FILE_INPUT=Z:\DEV\MODELO\DADOS_ESTATISTICAS.SQL
set FILE_ORIGEM=C:\TEMP\DADOS_ORIGEM.FDB
set FILE_DESTINO=C:\TEMP\DADOS_ORIGEM.FDB

set MSG_OK=Informações coletadas
set MSG_ERRORDEFAULT=Não foi possível coletar informações
set MSG_ERRO=Erro inesperado

::MAIN
::--------------------------------------------------
if [%1] NEQ [] (
	if %1 NEQ 1 (
		if %1 NEQ 2 (
			@echo "Sintaxe correta: CMD [1|2]"
		)
	)
) else (
	rem Parametro vazio
	@echo 1. ORIGEM
	@echo 2. DESTINO
	set /p ESCOLHA=">"||set ESCOLHA=NUL
)
if "%ESCOLHA%"=="1" goto:COLETA_ORIGEM
if "%ESCOLHA%"=="2" goto:COLETA_DESTINO

:COLETA_ORIGEM
	echo origem
	REM @"%EXE_ISQL%" -user %VAR_USER% -password %VAR_PASSWORD% -output "%FILE_OUTPUT%" -input "%FILE_INPUT%" "%FILE_ORIGEM%"
goto:exit
:COLETA_DESTINO
	echo origem
	REM @"%EXE_ISQL%" -user %VAR_USER% -password %VAR_PASSWORD% -output "%FILE_OUTPUT%" -input "%FILE_INPUT%" "%FILE_DESTINO%"
goto:exit

::--------------------------------------------------

::FUNCTIONS
::---------
:getPath
SETLOCAL
for /f "tokens=1,2,3,4 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"
(ENDLOCAL
	if %~1 == 1 set getPath_return=%PASTA_ATUAL[1]%
	if %~1 == 2 set getPath_return=%PASTA_ATUAL[2]%
	if %~1 == 3 set getPath_return=%PASTA_ATUAL[3]%
	if %~1 == 4 set getPath_return=%PASTA_ATUAL[4]%
)
goto:eof

::SAIDAS
::------
:EXIT
echo.&echo %MSG_OK%&timeout 10>nul&goto:END

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END

:END