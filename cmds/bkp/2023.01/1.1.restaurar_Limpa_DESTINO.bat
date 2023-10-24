::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

::VARIAVEIS
::---------
REM Variaveis de Ambiente
@set VAR_PC_AUTORIZADO=PROG19-VM
@set PATH_BASES=C:\_tmp\_bases\_importacao
@set PATH_CTEMP=C:\_tmp\_imp
@set PATH_FB3=%ProgramFiles%\Firebird\Firebird_3_0
@set PATH_BASELIMPA=R:\17 - BaseLimpa
@set FB3_USER=SYSDBA
@set FB3_SENHA=masterkey
REM Variaveis de Caminho
call:getPath 2
set PATH_IMPORTACAO=%PATH_BASES%\%getPath_return%

call:getImportacaoID "%getPath_return%"
set VAR_IMPORTACAO_ID=%getImportacaoID_return%

call:getPath 3
set PATH_WORKSPACE=%PATH_IMPORTACAO%\%getPath_return%

@set PATH_ORIGEM=%PATH_WORKSPACE%\ORIGEM
@set PATH_DESTINO=%PATH_WORKSPACE%\DESTINO
@set PATH_SCRIPTS=%PATH_WORKSPACE%\SCRIPTS
REM Variaveis de Arquivo
call:DataBaseLimpa
call:getLimpa N
@set FILE_BASELIMPAEXE_ORIGEM=%PATH_BASELIMPA%\%DataBaseLimpa_return%
@set FILE_BASELIMPAEXE_DESTINO=%PATH_WORKSPACE%\DESTINO\%FILE_LIMPA_EXE%
@set FILE_DESTINO_LIMPA=%PATH_DESTINO%\LIMPA.BCK
@set FILE_CTEMP_LIMPA=%PATH_CTEMP%\LIMPA.BCK
@set FILE_CTEMP_DADOS=%PATH_CTEMP%\TEMP.FDB
@set FILE_DESTINO_DADOS=%PATH_DESTINO%\DADOS.FDB
REM Variaveis de Aplicativo
@set EXE_GBAK=%PATH_FB3%\GBAK.EXE
REM Variaveis de Texto
@set MSG_OK=Base limpa restaurada
@set MSG_ERRORDEFAULT= N�o foi poss�vel restaurar
@set MSG_ERRO=Erro inesperado
@set MSG_AMBIENTE=Este script n�o pode ser executado fora do ambiente
::MAIN
::----------------------------------------------------------------------

@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (
	if exist "%FILE_DESTINO_DADOS%" goto:DadosExiste
	@echo Extraindo %FILE_LIMPA_EXE%...
	if exist "%FILE_BASELIMPAEXE_DESTINO%" (
		@"!FILE_BASELIMPAEXE_DESTINO!" -s >nul
	) else (
		@copy "%FILE_BASELIMPAEXE_ORIGEM%" "%FILE_BASELIMPAEXE_DESTINO%" >nul
		timeout 10 >nul
		@"!FILE_BASELIMPAEXE_DESTINO!" -s >nul
	)
	@echo Restaurando Base Limpa...
	if exist "%FILE_CTEMP_LIMPA%" del "%FILE_CTEMP_LIMPA%"
	if exist "%FILE_CTEMP_DADOS%" del "%FILE_CTEMP_DADOS%"
	@copy "%FILE_DESTINO_LIMPA%" "%FILE_CTEMP_LIMPA%" >nul
	@"%EXE_GBAK%" -c -user %FB3_USER% -pass %FB3_SENHA% "%FILE_DESTINO_LIMPA%" "%FILE_CTEMP_DADOS%"
	if %ERRORLEVEL% NEQ 0 goto:ERROR
	@copy "%FILE_CTEMP_DADOS%" "%FILE_DESTINO_DADOS%" >nul
	if exist "%FILE_CTEMP_LIMPA%" del "%FILE_CTEMP_LIMPA%"
	if exist "%FILE_CTEMP_DADOS%" del "%FILE_CTEMP_DADOS%"
	if exist "%FILE_DESTINO_LIMPA%" del "%FILE_DESTINO_LIMPA%"
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
goto:EXIT

::EXIT
::----------------------------------------------------------------------
:EXIT
@echo.&echo %MSG_OK%.&timeout 10&goto:END

::ERROR
::-----
:DadosExiste
@set MSG_ERRO="%FILE_DESTINO_DADOS%" j� existe
goto:ERROR

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%! &pause>nul&goto:END

::FUNCOES
::-------
:getLimpa Anterior
if "%~1"=="S" (
	call:DataAmericana N N S
	set FILE_LIMPA_EXE=LIMPA!DataAmericana_return!.EXE
	set FILE_LIMPA=%PATH_BASELIMPA%\!FILE_LIMPA_EXE!
) else (
	call:DataAmericana N S
	set FILE_LIMPA_EXE=LIMPA!DataAmericana_return!.EXE
	set FILE_LIMPA=%PATH_BASELIMPA%\!FILE_LIMPA_EXE!
)
goto:eof

:getImportacaoID vPath
SETLOCAL
for /f "tokens=1 delims= " %%i in ("%~1") do set "VAR_ID=%%i"
(ENDLOCAL
	set getImportacaoID_return=%VAR_ID%
)
@goto:eof

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

:DeletaCTemp
del "%FILE_CTEMP_DADOS%"
goto:eof

:DataBaseLimpa
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
if %DIA% EQU 08 set DIA=8
if %DIA% EQU 09 set DIA=9
set /a DIA=%DIA%-1
( SETLOCAL
	set TAMANHO=...
	call:strLen DIA TAMANHO
)
( ENDLOCAL
	IF %TAMANHO% LSS 2 SET "DIA=0%DIA%"
)
set "DataBaseLimpa_return=LIMPA%ANO%%MES%%DIA%.EXE"
goto:eof

:DataAmericana Pontos DiaMenosUm GetUltimoDiaMesAnterior
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
if %DIA% EQU 08 set DIA=8
if %DIA% EQU 09 set DIA=9
::GetUltimoDiaMesAnterior
if "%~3"=="S" (
	if %DIA% EQU 01 (
		if "%MES%"=="02" set "DIA=31"
		if "%MES%"=="03" set "DIA=28"
		if "%MES%"=="04" set "DIA=31"
		if "%MES%"=="05" set "DIA=30"
		if "%MES%"=="06" set "DIA=31"
		if "%MES%"=="07" set "DIA=30"
		if "%MES%"=="08" set "DIA=31"
		if "%MES%"=="09" set "DIA=31"
		if "%MES%"=="10" set "DIA=30"
		if "%MES%"=="11" set "DIA=31"
		if "%MES%"=="12" set "DIA=30"
		if "%MES%"=="01" set "DIA=31"
		if %MES% GTR 1 (
			set /a "MES=%MES%-1"
		) else (
			set "MES=12"
		)
	)
)
::----------
if "%~2"=="S" set /a DIA=%DIA%-1
( SETLOCAL
	set TAMANHO=...
	call:strLen DIA TAMANHO
)
( ENDLOCAL
	IF %TAMANHO% LSS 2 SET "DIA=0%DIA%"
)
( SETLOCAL
	set "TAMANHO="
	call:strLen MES TAMANHO
)
( ENDLOCAL
	IF %TAMANHO% LSS 2 SET "MES=0%MES%"
)
if "%~1"=="S" (
	@set "DataAmericana_return=%ANO%.%MES%.%DIA%"
) else (
	@set "DataAmericana_return=%ANO%%MES%%DIA%"
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

:END