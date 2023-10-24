REM ENVIRONMENT ====================================================================
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

:: FUNCTIONS ======================================================================
set UNIDADE=%~d0
set PATH_SCRIPT=%~0
call:getPath 1
set WS_BASES=%getPath_return%
call:getPath 2
set IMP_NOME=%getPath_return%
call:getPath 3
set PASTA=%getPath_return%
call:DataAmericano
set IMP_DATA=%HOJE%
goto:end_functions

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
:END_FUNCTIONS
:: END FUNCTIONS ==================================================================

:: SET PATH FILES ==================================================================
set PATH_ORIGEM=%UNIDADE%\%WS_BASES%\%IMP_NOME%\DESTINO
set PATH_DESTINO=%PATH_ORIGEM%
:: --------------------------------------------------------------------------------
set PATH_7ZIP=%ProgramFiles%\7-Zip\7z.exe
set PATH_7ZIP_PORTABLE=E:\BACKUP\Downloads\7z1805-extra\7za.exe
set EXE_GBAK=%ProgramFiles%\Firebird\Firebird_3_0\gbak.exe
set FILE_FDB=%PATH_ORIGEM%\DADOS.FDB
set FILE_OLDER=%PATH_ORIGEM%\DADOS_CLIENTE.FDB
set FILE_OLDER_BCK=%PATH_ORIGEM%\DADOS_CLIENTE.BCK
set FILE_ZIP=%PATH_ORIGEM%\DADOS_CLIENTE.ZIP
:: --------------------------------------------------------------------------------
:: SET PATH FILES ==================================================================
set USER=sysdba
set SENHA=masterkey

@echo CRIANDO CLIENTE: "%IMP_NOME%"
@echo ================================================================================
@echo.
@if not exist "%FILE_ZIP%" goto CRIA_DADOS_CLIENTE
	@del "%FILE_FDB%"
	@"%PATH_7ZIP_PORTABLE%" e -o"%PATH_ORIGEM%" "%FILE_ZIP%" -y -sdel
	if %ERRORLEVEL% NEQ 0 goto:ERROR
		@"%EXE_GBAK%" -c -v -user %USER% -pass %SENHA% "%FILE_OLDER_BCK%" "%FILE_OLDER%"
		if %ERRORLEVEL% NEQ 0 goto:ERROR
			@del "%FILE_OLDER_BCK%"
			@copy "%FILE_OLDER%" "%FILE_FDB%" /y
			if %ERRORLEVEL% NEQ 0 goto:ERROR
				@del "%FILE_OLDER%"
			
goto:exit

:CRIA_DADOS_CLIENTE
@echo.
@copy "%FILE_FDB%" "%FILE_OLDER%" /y
@"%EXE_GBAK%" -b -v -user %USER% -pass %SENHA% "%FILE_OLDER%" "%FILE_OLDER_BCK%"
if %ERRORLEVEL% NEQ 0 goto:ERROR
	@del "%FILE_OLDER%"
	@"%PATH_7ZIP_PORTABLE%" a -tzip "%FILE_ZIP%" "%FILE_OLDER_BCK%" -r- -y
	if %ERRORLEVEL% NEQ 0 goto:ERROR
		@del "%FILE_OLDER_BCK%"
goto:exit

:EXIT
@echo ================================================================================
echo.&echo BASE CLIENTE CRIADA !&pause>nul&goto:END

:ERROR
echo.&echo SAINDO COM ERRO. . .&pause>nul&goto:END

:END