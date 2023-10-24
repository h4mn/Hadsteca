@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@cls
@echo ===============================================================================
rem CHAMADA A FUNCTION

call:PastaAtual
@echo !PASTA_ATUAL[4]!

pause
@goto:eof

:PastaAtual
REM echo %~p0
REM echo.
@for /f "tokens=1,2,3,4 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"
@goto:eof

pause
:EXIT
