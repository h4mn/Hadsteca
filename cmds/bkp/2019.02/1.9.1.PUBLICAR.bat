::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul
::VARIAVEIS
::---------
rem Caminhos
set PATH_DEV=Z:\DEV
set PATH_CTEMP=C:\TEMP
set PATH_BASES=Z:\BASES
set PATH_FINAL=I:\BasesImportadas
call:getPath 2
set IMP_NOME=%getPath_return%
call:DataAmericana S
call:HoraAmericana S
set FILE_IMP_TS_ATUAL=TS_ATUAL.INI
set FILE_IMPORTADAS=IMPORTADAS.LOG
set PATH_IMP_TS_ATUAL=%PATH_BASES%\!getPath_return!\%FILE_IMP_TS_ATUAL%
set /p VAR_TS_ATUAL=<!PATH_IMP_TS_ATUAL!
set PATH_WORKSPACE=%PATH_BASES%\%IMP_NOME%\!VAR_TS_ATUAL!\DESTINO
set VAR_AGORA=%DataAmericana_return%_%HoraAmericana_return%
set PATH_IMPORTACAO=%PATH_FINAL%\%IMP_NOME%\%VAR_AGORA%
set PATH_IMPORTADAS=%PATH_DEV%\%FILE_IMPORTADAS%
rem Arquivos
@set FILE_FDB=%PATH_WORKSPACE%\DADOS.FDB
@set FILE_FDB_TEMP=%PATH_CTEMP%\DADOS.FDB
@set FILE_BCK_TEMP=%PATH_CTEMP%\DADOS.BCK
@set FILE_ZIP_TEMP=%PATH_CTEMP%\DADOS.ZIP
@set FILE_ZIP=%PATH_IMPORTACAO%\DADOS.ZIP
rem Aplicativos
@set EXE_7ZIP=%ProgramFiles%\7-Zip\7z.exe
@set EXE_GBAK=%ProgramFiles%\Firebird\Firebird_3_0\gbak.exe
rem Ambiente
@set USER=sysdba
@set SENHA=masterkey
set "VAR_TAB=    "
rem Mensagem
@set MSG_OK=Publicacao finalizada
@set MSG_ERRORDEFAULT=Não foi possível fazer a publicação
@set MSG_ERRO=Erro inesperado
@set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
@set MSG_INICIAL=Iniciando publicação da Base %IMP_NOME:~0,4%
@set MSG_FILENOTFOUND=Arquivo %FILE_FDB% não encontrado

:::MAIN
:::----------------------------------------------------------------------
@if %COMPUTERNAME% EQU DESKTOP-4A54RRC (
	@echo.
	@echo %MSG_INICIAL%...
	if exist "%FILE_FDB%" (
		call:LimpaTemp
		@echo - Copying %FILE_FDB_TEMP%...
		@copy "%FILE_FDB%" "%FILE_FDB_TEMP%" /y >nul
		@echo - Gbaking %FILE_BCK_TEMP%...
			@"%EXE_GBAK%" -b -user %USER% -pass %SENHA% "%FILE_FDB_TEMP%" "%FILE_BCK_TEMP%"
			if %ERRORLEVEL% NEQ 0 goto:ERROR
		@echo - 7Ziping %FILE_ZIP_TEMP%...
			@"%EXE_7ZIP%" a -tzip "%FILE_ZIP_TEMP%" "%FILE_BCK_TEMP%" -y -sdel >nul
			if %ERRORLEVEL% NEQ 0 goto:ERROR
		@echo - Creating %IMP_NOME%\%VAR_AGORA%...
			@md "%PATH_IMPORTACAO%" >nul
		@echo - Copying %IMP_NOME%\%VAR_AGORA%\DADOS.ZIP...
			@copy "%FILE_ZIP_TEMP%" "%FILE_ZIP%" /y >nul
		call:LimpaTemp
	) else (
		@set MSG_ERRO=%MSG_FILENOTFOUND%
		goto:ERROR
	)
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
set PATH_IMPORTADAS_MSG=[IMPORTACAO]%FILE_ZIP%
@echo %PATH_IMPORTADAS_MSG%
@echo %PATH_IMPORTADAS_MSG%|clip
call:ImportadasLog "%PATH_IMPORTADAS%" "%PATH_IMPORTADAS_MSG%"
goto:exit

:ImportadasLog File Msg
@echo %~2>> %~1
goto:eof

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