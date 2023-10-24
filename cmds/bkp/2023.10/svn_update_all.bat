@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

set TRUNK=C:\_Fontes\trunk
set IMPORTACAO=C:\_Fontes\Importacao
set BRANCH_1=C:\_Fontes\2020.05.18

svn info %IMPORTACAO%
echo.

svn update %BRANCH_1%
echo.

svn update %TRUNK%
echo.

svn info %TRUNK%

@echo.&echo All Updated! &pause>nul