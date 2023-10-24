::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul
::VARIAVEIS
::---------
rem Ambiente
@set VAR_PC_AUTORIZADO=PROG19-VM
@set PATH_WORKSPACE=C:\Temp
@set PATH_BACKUP=%PATH_WORKSPACE%\Backup_RTM
@set EXE_7ZIP=%ProgramFiles%\7-Zip\7z.exe
@set "RTM_FILES=%PATH_WORKSPACE%\*.rtm"
@set "VAR_TAB=    "

rem Mensagens
set MSG_TITLE=Utilitário Backup RTM Temp:
set MSG_OK=Backup realizado
set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
set MSG_ERROCAMINHO=Caminho não existe
set MSG_INPUT=Escolher Branch:
set MGS_ERRORDEFAULT=Não foi possível fazer backup
set MSG_ERRO_SOTRUNK=Envia apenas a partir da Trunk

::MAIN
@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (
	title %MSG_TITLE%
	rem ----------------------------
	if not exist %PATH_BACKUP% mkdir %PATH_BACKUP%
	if exist %PATH_BACKUP% (
		call:DataAmericana S
		call:HoraAmericana S
		set FILE_ZIP=%PATH_BACKUP%\!DataAmericana_return!_!HoraAmericana_return!.zip
		@"%EXE_7ZIP%" a -tzip "!FILE_ZIP!" "%RTM_FILES%" -y -sdel >nul
	) else (
		set MSG_ERRO=%MSG_ERROCAMINHO%
		goto:error
	)
	rem ----------------------------
) else (
	set MSG_ERRO=%MSG_AMBIENTE%
	goto:error
)
goto:exit

::FUNCTIONS
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

::SAIDAS
:EXIT
rem Prompt com confirmação visual
rem @echo %MSG_OK%... &pause>nul

rem Sem confirmação visual
@echo %MSG_OK%
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END
