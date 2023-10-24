::CABECALHO
::---------
@echo off
@cls
@chcp 1252 >nul
::VARIAVEIS
::---------
@set VAR_PC_AUTORIZADO=PROG19-VM
rem CaminhoS
set PATH_BASES=C:\_tmp\_bases\_importacao
set PATH_CTEMP=C:\_tmp\_imp
call:getPath 4
set PATH_IMPORTACAO=%PATH_BASES%\%getPath_return%
call:getPath 5
set PATH_WORKSPACE=%PATH_IMPORTACAO%\%getPath_return%
rem Arquivos
set FILE_DADOS=%PATH_IMPORTACAO%\%getPath_return%\ORIGEM\DADOS.FDB
set FILE_ORIGEM=%PATH_CTEMP%\DADOS_ORIGEM.FDB
rem echo "%FILE_ORIGEM%"&pause&goto:exit
rem Ambiente
set "VAR_TAB=    "
set "VAR_LOCKED=0"
rem Mensagens
set MSG_AMBIENTE=Este script n�o pode ser executado fora do ambiente
set MSG_ERRO=Erro inesperado
rem ---------
set MSG_INICIAL=Atualizando Dados Origem...
set MSG_ERRORDEFAULT=N�o foi poss�vel atualizar
set MSG_ERRO_1=Arquivo em uso
set MSG_OK=Dados Origem atualizado
::MAIN
::--------------------------------------------------
@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (

	@echo %MSG_INICIAL%
	@echo %VAR_TAB%- Apagando ..\ORIGEM\DADOS.FDB
	if exist "%FILE_DADOS%" (
		( type nul >> "%FILE_DADOS%" ) 2>nul || set VAR_LOCKED=1
		if "%VAR_LOCKED%"=="0" (
			del "%FILE_DADOS%" >nul
		) else (
			set MSG_ERRO=%MSG_ERRO_1%
			goto:ERROR
		)
	)
	@echo %VAR_TAB%- Copiando ..CTEMP\DADOS_ORIGEM.FDB para ..\ORIGEM\DADOS.FDB
	copy "%FILE_ORIGEM%" "%FILE_DADOS%" >nul
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
goto:exit
::--------------------------------------------------

::FUNCTIONS
::---------
:getPath
SETLOCAL
for /f "tokens=1,2,3,4,5 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"&set "PASTA_ATUAL[5]=%%e"
(ENDLOCAL
	if %~1 == 1 set getPath_return=%PASTA_ATUAL[1]%
	if %~1 == 2 set getPath_return=%PASTA_ATUAL[2]%
	if %~1 == 3 set getPath_return=%PASTA_ATUAL[3]%
	if %~1 == 4 set getPath_return=%PASTA_ATUAL[4]%
	if %~1 == 5 set getPath_return=%PASTA_ATUAL[5]%
)
goto:eof

::SAIDAS
::------
:EXIT
echo.&echo %MSG_OK%&timeout 10>nul&goto:END

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END

:END