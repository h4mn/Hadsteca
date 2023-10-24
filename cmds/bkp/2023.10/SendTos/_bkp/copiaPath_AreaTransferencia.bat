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
@set PATH_WORKSPACE=C:\_Fontes
set "VAR_TAB=    "
rem Mensagens
set MSG_TITLE=Capturar Path:
set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
set MSG_INICIAL=Path enviado para Área de Transferência:
set MSG_INPUT=Escolher Branch:
SET MGS_ERRORDEFAULT=Não foi possível enviar arquivo
set MSG_ERROCAMINHO=Caminho não existe
set MSG_ERRO_SOTRUNK=Envia apenas a partir da Trunk


::MAIN
@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (
	title %MSG_TITLE%
	set _DE=%1
	rem ENVIAR PARA
	rem ----------------------------
	@echo %MSG_INICIAL%
	@echo %VAR_TAB%PATH: !_DE!
	@echo.
	@echo.
	@echo !_DE! |clip
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

::SAIDAS
:EXIT
@echo Arquivo copiado... &pause>nul
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END
