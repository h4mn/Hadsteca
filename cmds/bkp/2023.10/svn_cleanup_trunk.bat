@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

set TRUNK=C:\_Fontes\trunk
set IMPORTACAO=C:\Fontes\Importação
set BRANCH_06=C:\_Fontes\2019.06.17
set BRANCH_07=C:\_Fontes\2019.07.15
set BRANCH_08=C:\_Fontes\2019.08.12
set BRANCH_09=C:\_Fontes\2019.09.09
set BRANCH_10=C:\_Fontes\2019.10.07
set BRANCH_11=C:\_Fontes\2019.11.04
set BRANCH_12=C:\_Fontes\2019.12.02

rem svn update %BRANCH_12%
rem echo.
svn cleanup %TRUNK%
echo.


@echo.&echo Trunk Limpa! &pause>nul