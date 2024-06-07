:: Cabeçalho
:: ============================================================================
:: Script     : deleta_todos_exe_trunk.bat
:: DescriÃ§Ã£o  : Deleta todos os arquivos .exe do diretório trunk
:: Autor      : Hadston Nunes
:: Data       : 2024.05.21
:: VersÃ£o     : 1.0
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
:: Deleta todos os arquivos .exe do diretório trunk e de todos seus subdiretórios
:: ============================================================================
@echo.
@echo Deletando arquivos .exe do diretório trunk ...
@echo.
:: /r - Processa arquivos em todos os subdiretórios
:: (*.exe) - Filtra arquivos .exe
for /r "%PATH_TRUNK%" %%i in (*.exe) do (
    @echo %STR_TAB%Deletando %%i ...

    :: /f - Força a exclusão do arquivo
    :: /q - Não exibe mensagem de confirmação
    :: /s - Exclui arquivos de todos os subdiretórios
    del /f /q /s "%%i"
)
@echo.
@echo Todos os arquivos .exe do diretório trunk foram deletados !&pause > nul