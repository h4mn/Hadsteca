@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
chcp 1252 >nul

@set VAR_PC_AUTORIZADO=PROG19-VM
@set PATH_FOLDERS=C:\_Fontes\trunk\Empresa
@set PATH_CTEMP=C:\TEMP
@set PATH_FILE_NAMEFOLDERS=%PATH_CTEMP%\lista_especificos.txt

set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
set MSG_INICIAL=Criando lista com os nomes das pastas
set MSG_OK=Lista Criada

@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (
	@echo %MSG_INICIAL%
	@echo.
	if exist %PATH_FOLDERS% (
		for /d %%p in (%PATH_FOLDERS%\*) do >> %PATH_FILE_NAMEFOLDERS% echo %%~nxp
	)
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR	
)
goto:EXIT

:EXIT
if "%PARAM_ORIGEM%"=="" @echo.&echo %MSG_OK%.&timeout 10&goto:END
goto:end

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%! &pause>nul&goto:END

:END
@pause