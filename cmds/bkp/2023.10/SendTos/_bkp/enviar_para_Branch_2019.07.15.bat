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


@set BRANCH_201907=2019.07.15


@set _DE=%1
@set _PARA=%PATH_WORKSPACE%\%BRANCH_201907%\%_DE:~17%

@echo Copiando
@echo.
@echo De:   %_DE%
@echo Para: %_PARA%
@echo.
@echo.
@xcopy "%_DE%" "%_PARA%" /y >nul

@echo %_PARA% |clip
rem explorer "%_PARA%"
@echo Arquivo copiado... &pause>nul

