::HEAD
::----------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

::INPUTS
::----------
rem Mensagens
set MSG_TITLE=SVN Update
set MSG_ERRORDEFAULT=Não foi possível realizar esta tarefa.
set MSG_ERROAMBIENTE=Este script não pode ser executado fora do Ambiente.
set MSG_ERRO=Erro inesperado.
set MSG_OK=Repositório atualizado.
rem Ambiente
set PATH_SVN=C:\_Fontes
set PATH_WS=C:\Temp\scripts
rem Aplicativos
set APP_SVN=%ProgramFiles%\TortoiseSVN\bin\svn.exe
rem Objetos
set OBJ_TRUNK=trunk
set OBJ_ANTERIOR=2020.05.18

::MAIN
::----------
if "%COMPUTERNAME%" EQU "DESKTOP-4A54RRC" (
    if "%PATH_WS%\" EQU "%~d0%~p0" (
        call:SVN_UPDATE %PATH_SVN%\%OBJ_ANTERIOR%
        call:SVN_UPDATE %PATH_SVN%\%OBJ_TRUNK%
    ) else (
        set %MSG_ERRO%=%MSG_ERROAMBIENTE%
        goto:ERROR
    )
) else (
    set %MSG_ERRO%=%MSG_ERROAMBIENTE%
    goto:ERROR
)
goto:EXIT

::FUNCTIONS
::----------
:SVN_UPDATE path
    echo Atualizando "%~1"...
    echo ========================================
    echo.
    "%APP_SVN%" info "%~1"
    "%APP_SVN%" update "%~1"
    echo.&echo.
goto:eof

::OUTPUTS
::----------
:EXIT
@echo.&echo %MSG_OK%&timeout 10>nul
goto:END

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul
goto:END

::THEBIGEND
::----------
:END