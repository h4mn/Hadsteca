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
::==================================================
@set PATH_WORKSPACE=C:\_tmp\_fontes
::==================================================
set "VAR_TAB=    "
rem Mensagens
set MSG_TITLE=Copiar Atalho
set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
set MSG_INICIAL=Caminho completo do arquivo:
set MSG_SAIDA=Path copiado...
set MSG_INPUT=
set MGS_ERRORDEFAULT=Não foi possível ler arquivo
set MSG_ERROCAMINHO=Caminho não existe

::MAIN
	title %MSG_TITLE%
	set _DE=%1
	@echo %MSG_INICIAL%
	@echo %VAR_TAB%!_DE!
	@echo !_DE! |clip
	@echo.
	goto:exit

::SAIDAS
:EXIT
@echo %MSG_SAIDA% &pause>nul
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END