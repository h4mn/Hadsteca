::CABECALHO
::---------
@echo off
@cls
@chcp 1252 >nul
::VARIAVEIS
::---------
@set VAR_PC_AUTORIZADO=PROG19-VM
rem Caminhos
set PATH_BASES=E:\BASES
set PATH_CTEMP=C:\TEMP

set IP_INTERNO=192.168.1.2
set IP_HOFFICE=10.200.0.2
set UNIDADE_CONECTAR=F

call:getPath 2
set PATH_IMPORTACAO=%PATH_BASES%\%getPath_return%
call:getPath 3
set PATH_WORKSPACE=%PATH_IMPORTACAO%\%getPath_return%
rem Arquivos
set FILE_DADOS=%PATH_IMPORTACAO%\%getPath_return%\ORIGEM\DADOS.FDB
set FILE_ORIGEM=%PATH_CTEMP%\DADOS_ORIGEM.FDB
rem Ambiente
set "VAR_TAB=    "
set "VAR_LOCKED=0"
rem Mensagens
set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
set MSG_ERRO=Erro inesperado
rem ---------
set MSG_INICIAL=Conectando unidades...
set MSG_ERRORDEFAULT=Não foi possível conectar
set MSG_ERRO_1=Arquivo em uso
set MSG_OK=Unidade conectada!
::MAIN
::--------------------------------------------------
@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (

	@echo %MSG_INICIAL%
	@echo %VAR_TAB%- Apagando ..\ORIGEM\DADOS.FDB

rem net use f: /delete
rem net use f: \\10.200.0.2\Desenvolvimento /user:hadnun /persistent:yes
rem net use f: /delete
net use %UNIDADE_CONECTAR% "\\%IP_INTERNO%\Desenvolvimento" /user:hadnun /persistent:yes


goto:exit
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