::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

::VARIAVEIS
::---------
@set PATH_WORKSPACE=Z:\BASES
rem @set PATH_FB3=Z:\Firebird_3_0
@set PATH_FB3=%ProgramFiles%\Firebird\Firebird_3_0
@set PATH_CTEMP=C:\TEMP
call:getPath 2
@set PATH_ORIGEM=%PATH_WORKSPACE%\%getPath_return%\ORIGEM
@set PATH_DESTINO=%PATH_WORKSPACE%\%getPath_return%\DESTINO
@set PATH_SCRIPT=%PATH_WORKSPACE%\%getPath_return%\SCRIPTS

@set FILE_DADOSORIGEM=%PATH_ORIGEM%\DADOS.FDB
@set FILE_SQLNEWDB=%PATH_SCRIPT%\1.1.NOVA_ORIGEM.SQL
@set FILE_DADOSTEMP=%PATH_CTEMP%\DADOS_NOVA.FDB

@set EXE_ISQL=%PATH_FB3%\ISQL.EXE

@set MGS_OK=Base nova criada
@set MGS_ERRODEFAULT=Não é possível criar uma base nova
@set MSG_ERRO=Erro inesperado

::MAIN
::----------------------------------------------------------------------
@if %COMPUTERNAME% EQU DESKTOP-4A54RRC (
	@if exist "%FILE_DADOSORIGEM%" goto:DadosOrigemExiste
		@if exist "%FILE_DADOSTEMP%" del "%FILE_DADOSTEMP%"
		@"%EXE_ISQL%" -input "%FILE_SQLNEWDB%" -quiet >nul
		@if %ERRORLEVEL% NEQ 0 goto:ERROR
		@copy "%FILE_DADOSTEMP%" "%FILE_DADOSORIGEM%" >nul
		@del "%FILE_DADOSTEMP%" 
		@goto:EXIT
) else (
	@set MSG_ERRO=Este script não pode ser executado fora do ambiente
	@goto:ERROR
)

::EXIT
::----------------------------------------------------------------------
:EXIT
@echo.&echo %MGS_OK%.&timeout 10&goto:END

::ERROR
::-----
:DadosOrigemExiste
@set MSG_ERRO=O arquivo %FILE_DADOSORIGEM% já existe
goto:ERROR
:ERROR
@echo.&echo %MGS_ERRODEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END

::FUNCOES
::-------
:getPath
SETLOCAL
for /f "tokens=1,2,3,4 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"
(ENDLOCAL
	if %~1 == 1 set getPath_return=%PASTA_ATUAL[1]%
	if %~1 == 2 set getPath_return=%PASTA_ATUAL[2]%
	if %~1 == 3 set getPath_return=%PASTA_ATUAL[3]%
	if %~1 == 4 set getPath_return=%PASTA_ATUAL[4]%
)
@goto:eof

:DeletaFDBCTemp
del "%FILE_DADOSTEMP%"
@goto:eof

:END