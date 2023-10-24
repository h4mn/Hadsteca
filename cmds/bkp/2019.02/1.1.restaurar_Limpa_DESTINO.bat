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
@set PATH_WORKSPACE=Z:\BASES
@set PATH_CTEMP=C:\TEMP
@set PATH_FB3=%ProgramFiles%\Firebird\Firebird_3_0
@set PATH_BASELIMPA=R:\17 - BaseLimpa
@set FB3_USER=SYSDBA
@set FB3_SENHA=masterkey
REM Variaveis de Caminho
call:getPath 2
@set PATH_IMPORTACAO=%PATH_WORKSPACE%\%getPath_return%
@set PATH_ORIGEM=%PATH_IMPORTACAO%\ORIGEM
@set PATH_DESTINO=%PATH_IMPORTACAO%\DESTINO
@set PATH_SCRIPTS=%PATH_IMPORTACAO%\SCRIPTS
REM Variaveis de Arquivo
call:DataBaseLimpa
@set FILE_BASELIMPAEXE=%PATH_BASELIMPA%\%DataBaseLimpa_return%
@set FILE_DESTINO_LIMPA=%PATH_DESTINO%\LIMPA.BCK
@set FILE_CTEMP_LIMPA=%PATH_CTEMP%\LIMPA.BCK
@set FILE_CTEMP_DADOS=%PATH_CTEMP%\TEMP.FDB
@set FILE_DESTINO_DADOS=%PATH_DESTINO%\DADOS.FDB
REM Variaveis de Aplicativo
@set EXE_GBAK=%PATH_FB3%\GBAK.EXE
REM Variaveis de Texto
@set MSG_OK=Base limpa restaurada
@set MSG_ERRORDEFAULT= Não foi possível restaurar
@set MSG_ERRO=Erro inesperado
@set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
::MAIN
::----------------------------------------------------------------------

if %COMPUTERNAME% EQU DESKTOP-4A54RRC (
	if exist "%FILE_DESTINO_DADOS%" goto:DadosExiste
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
@set MSG_ERRO="%FILE_DESTINO_DADOS%" já existe
goto:ERROR

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%! &pause>nul&goto:END

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