::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL DISABLEDELAYEDEXPANSION
@chcp 1252 >nul
::VARIAVEIS
::---------
rem Caminhos
set PATH_DEV=Z:\DEV
set PATH_BASES=Z:\BASES
set PATH_CTEMP=C:\TEMP
set PATH_FINAL=I:\BasesImportadas
rem Arquivos
set FILE_IMPORTACAO_LOG=IMPORTACAO.LOG

rem Mensagem
@set MSG_OK=Publicacao finalizada
@set MSG_ERRORDEFAULT=Não foi possível fazer a publicação
@set MSG_ERRO=Erro inesperado
@set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
@set MSG_INICIAL=Iniciando publicação da Base 
@set MSG_FILENOTFOUND=Arquivo não encontrado
:::MAIN
:::----------------------------------------------------------------------
set PATH_IMPORTACAO_LOG=%PATH_DEV%\%FILE_IMPORTACAO_LOG%
set VAR_STR_FIND=8086
set VAR_STR_SUBS=TESTE
@if %COMPUTERNAME% EQU DESKTOP-4A54RRC (
	@echo %MSG_INICIAL%...
	for /f "tokens=1,* delims=]" %%a in ('"type %PATH_IMPORTACAO_LOG%|find /n /v """') do (
		set "VAR_LINE=%%b"
		set "VAR_NUM=%%a"
		@echo !VAR_NUM!
		if defined VAR_LINE (
			call set "VAR_LINE=echo.%%VAR_LINE:"%VAR_STR_FIND%"="%VAR_STR_SUBS%"%%"
			rem for /f "delims=" %%x in ('"@echo."%%VAR_LINE%%""') do %%~x
			rem @echo !VAR_LINE!
		) else echo.
	)
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
goto:end
goto:exit

::FUNCTIONS
::---------
:LimpaTemp
if exist !FILE_FDB_TEMP! del !FILE_FDB_TEMP! >nul
if exist !FILE_BCK_TEMP! del !FILE_BCK_TEMP! >nul
if exist !FILE_ZIP_TEMP! del !FILE_ZIP_TEMP! >nul
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

:DataAmericana Pontos
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
if %DIA% EQU 08 set DIA=8
if %DIA% EQU 09 set DIA=9
::set /a DIA=%DIA%-1
( SETLOCAL
	set TAMANHO=...
	call:strLen DIA TAMANHO
)
( ENDLOCAL
	IF %TAMANHO% LSS 2 SET "DIA=0%DIA%"
)
if "%~1"=="S" (
	@set "DataAmericana_return=%ANO%.%MES%.%DIA%"
) else (
	@set "DataAmericana_return=%ANO%%MES%%DIA%"
)
goto:eof

:HoraAmericana Pontos
set HORA=%time:~0,2%
set MINUTO=%time:~3,2%
set SEGUNDO=%time:~6,2%
( SETLOCAL
	set TAMANHO=...
	call:strLen HORA TAMANHO
)
( ENDLOCAL
	if %TAMANHO% LSS 2 (
		set "HORA=0%HORA%"
	) else (
		if "%HORA:~0,1%" EQU " " (
			set "HORA=0%HORA:~1,1%"
		)
	)
)
if "%~1"=="S" (
	@set "HoraAmericana_return=%HORA%.%MINUTO%.%SEGUNDO%"
) else (
	@set "HoraAmericana_return=%HORA%%MINUTO%%SEGUNDO%"
)
goto:eof

:strLen string len -- returns the length of a string
::                 -- string [in]  - variable name containing the string being measured for length
::                 -- len    [out] - variable to be used to return the string length
:: Many thanks to 'sowgtsoi', but also 'jeb' and 'amel27' dostips forum users helped making this short and efficient
:$created 20081122 :$changed 20101116 :$categories StringOperation
:$source https://www.dostips.com
(   SETLOCAL ENABLEDELAYEDEXPANSION
    set "str=A!%~1!"&rem keep the A up front to ensure we get the length and not the upper bound
                     rem it also avoids trouble in case of empty string
    set "len=0"
    for /L %%A in (12,-1,0) do (
        set /a "len|=1<<%%A"
        for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
    )
)
( ENDLOCAL & REM RETURN VALUES
    IF "%~2" NEQ "" SET /a %~2=%len%
)
goto:eof

::SAIDAS
::---------
:EXIT
echo.&echo %MSG_OK%&timeout 10>nul&goto:END
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END
ENDLOCAL