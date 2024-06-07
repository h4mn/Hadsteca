:: Cabe�alho
:: ============================================================================
:: Script     : deleta_todos_exe_trunk.bat
:: Descrição  : Deleta todos os arquivos .exe do diret�rio trunk
:: Autor      : Hadston Nunes
:: Data       : 2024.05.21
:: Versão     : 1.0
:: ----------
:: Ambiente
@echo off
setlocal enableextensions enabledelayedexpansion
chcp 1252 > nul
cls
:: ----------
:: Variaveis
set PATH_TRUNK=C:\_tmp\_fontes\trunk\
set "STR_TAB=    "

:: Main
:: ============================================================================
:: Deleta todos os arquivos .exe do diret�rio trunk e de todos seus subdiret�rios
:: ============================================================================
@echo.
@echo Deletando arquivos .exe do diret�rio trunk ...
@echo.
:: /r - Processa arquivos em todos os subdiret�rios
:: (*.exe) - Filtra arquivos .exe
for /r "%PATH_TRUNK%" %%i in (*.exe) do (
    @echo %STR_TAB%Deletando %%i ...

    :: /f - For�a a exclus�o do arquivo
    :: /q - N�o exibe mensagem de confirma��o
    :: /s - Exclui arquivos de todos os subdiret�rios
    del /f /q /s "%%i"
)
@echo.
@echo Todos os arquivos .exe do diret�rio trunk foram deletados !&pause > nul