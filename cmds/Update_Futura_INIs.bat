@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

::Ambiente
set "PARAMETRO_1=VERSAO_1" &rem 2019.09.16 Implementado codigo reusavel
rem set PATH_ROOT=Z:\BACKUP\_BASES\SISTEMAS
rem set PATH_ROOT=Z:\BACKUP\BACKUP\_BASES\SISTEMAS
rem set PATH_ROOT=E:\BACKUP\_BASES\SISTEMAS
rem set PATH_ROOT=F:\BACKUP\_BASES\SISTEMAS
::==================================================
set PATH_ROOT=Z:\Backup\_tmp\_cmd
set PATH_FUTURAINI=FUTURA.INI
set PATH_THIS_FILE=%~n0%~x0
set PATH_THIS_PATH=%~d0%~p0
set PATH_THIS_FULLPATH=%~f0
set PATH_FONTES=C:\_tmp\_fontes
set PATH_INSTALL=C:\FUTURA
set PATH_UTILITARIO_EXE=Z:\Backup\_tmp\_pas\HadsTemp\_EXE
::==================================================

::PATH INSTALL
set "PATH_INSTALL_FUTURAINI=%PATH_INSTALL%\%PATH_FUTURAINI%"

::PATH IMPORTACAO
set "PATH_IMPORTACAO=%PATH_UTILITARIO_EXE%\%PATH_FUTURAINI%"

:: Variaveis
set "VAR_TAB=    "

::Mensagens
set "MSG_TITLE=Atualizador dos Futura.ini"
set "MSG_INICIO=Iniciando atualizacao dos Futura.ini"
set "MSG_OK=Todos os Futura.ini configurados foram atualizados"
set "MSG_AMBIENTE=Funciona apenas no ambiente configurado ( %PATH_ROOT% )"
set "MSG_MAININI=Futura.ini principal nao encontrado"
::Main
REM VERIFICA O PATH ROOT
title %MSG_TITLE%
if "%PATH_ROOT%\%PATH_THIS_FILE%"=="%PATH_THIS_FULLPATH%" (
	REM VERIFICA O FUTURA.INI MAIN
	if exist "%PATH_ROOT%\%PATH_THIS_FILE%" (
		REM COPIA O FUTURA.INI PARA OS PATHS _EXE
		@echo %MSG_INICIO%&echo.
		if "%PARAMETRO_1%"=="VERSAO_1" (
			call:COPIAR "%PATH_IMPORTACAO%"
			call:COPIAR "%PATH_INSTALL_FUTURAINI%"
			call:SetCopyTag "%PATH_FONTES%\trunk"
			call:SetCopyTag "%PATH_FONTES%\2023.09.18"
			call:SetCopyTag "%PATH_FONTES%\2023.08.21"
			call:SetCopyTag "%PATH_FONTES%\2023.07.24"
		)
	) else (
		set "MSG_ERRO=%MSG_MAININI%"&goto:ERRO
	)
) else (
	set "MSG_ERRO=%MSG_AMBIENTE%"&goto:ERRO
)

goto:EXIT

::Functions
:SetCopyTag tag
::TODO: Implementar a pasta do tipo de versão (_EXE para 32bit / _EXE64 para 64bit)
call:COPIAR "%~1\Empresa\00000 - Generico\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00001 - Futura\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00111 - Campineira\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00158 - Nelida\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00171 - AEscolar\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00178 - MansurMotos\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00185 - Tendencia\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00871 - XT\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\01016 - NewGoods\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\01209 - Vicemar\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\02040 - CenterPanosFranquia\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\02220 - NipoCenter\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\03109 - CasaSafari\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\04801 - Dagia\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00483 - OticaRojo\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\03235 - ParisBijux\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\01284 - ANPP\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\01354 - Sieger\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\03730 - Hand Market\_EXE\%PATH_FUTURAINI%"
call:COPIAR "%~1\Empresa\00103 - TexPak\_EXE\%PATH_FUTURAINI%"


goto:eof

:COPIAR path
@copy "%PATH_ROOT%\%PATH_FUTURAINI%" "%~1" /y >nul&echo %VAR_TAB%%~1 copiado
goto:eof

::Saida
:EXIT
echo.&echo %MSG_OK%&pause>nul
goto:END

:ERRO
echo.&echo %MSG_ERRO%...&pause>nul
goto:END

:END
