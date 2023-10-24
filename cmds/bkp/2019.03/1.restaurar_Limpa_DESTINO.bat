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
:: END FUNCTIONS ==================================================================

:: SET PATH FILES ==================================================================
set PATH_ORIGEM=%UNIDADE%\%WS_BASES%\%IMP_NOME%\DESTINO
set PATH_DESTINO=%PATH_ORIGEM%
:: --------------------------------------------------------------------------------
set EXE_GBAK=%ProgramFiles%\Firebird\Firebird_3_0\gbak.exe
set FILE_BCK=%PATH_ORIGEM%\Limpa.bck
set FILE_FDB=%PATH_DESTINO%\DADOS.FDB
:: --------------------------------------------------------------------------------
:: SET PATH FILES ==================================================================
set USER=sysdba
set SENHA=masterkey

@echo RESTAURAR BASE LIMPA: "%IMP_NOME%"
@echo ================================================================================
@echo.
@"%EXE_GBAK%" -c -v -user %USER% -pass %SENHA% "%FILE_BCK%" "%FILE_FDB%"
if %ERRORLEVEL% NEQ 0 goto:ERROR
	@del "%FILE_BCK%"
goto:exit

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

:EXIT
echo.&echo BASE DESCOMPACTADA !&pause>nul&goto:END

:ERROR
echo.&echo %EXE_GBAK% EXECUTADO COM ERRO !&pause>nul&goto:END

:END