@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

::Ambiente
::==================================================
set "PARAMETRO_1=VERSAO_1" &rem 2019.09.16 Implementado codigo reusavel
set PATH_ROOT=C:\_tmp\_fontes\_hads\hadsteca\cmds
set PATH_FUTURAINI=FUTURA.INI
set PATH_THIS_FILE=%~n0%~x0
set PATH_THIS_PATH=%~d0%~p0
set PATH_THIS_FULLPATH=%~f0
set PATH_FONTES=C:\_tmp\_fontes
set PATH_INSTALL=C:\FUTURA
set PATH_UTILITARIO_EXE=Z:\Backup\_tmp\_pas\HadsTemp\_EXE

:: Variaveis
::==================================================
set "FILE_LOG=%PATH_THIS_PATH%update_futura_inis.log"
set "VAR_TAB=    "
set "FILE_PROCESSING_ORIGEM="
set "FILE_PROCESSING_DESTINO="

::Mensagens
set "MSG_TITLE=Atualizador dos Futura.ini"
set "MSG_INICIO=Iniciando atualizacao dos Futura.ini"
set "MSG_OK=Todos os Futura.ini configurados foram atualizados"
set "MSG_AMBIENTE=Funciona apenas no ambiente configurado ( %PATH_ROOT% )"
set "MSG_MAININI=Futura.ini principal nao encontrado"

::Main
::==================================================
title %MSG_TITLE%
if "%PATH_ROOT%\%PATH_THIS_FILE%"=="%PATH_THIS_FULLPATH%" (
	if exist "%PATH_ROOT%\%PATH_THIS_FILE%" (
		@echo %MSG_INICIO%&echo.
		@type nul > %FILE_LOG%
		if "%PARAMETRO_1%"=="VERSAO_1" (
			@echo %VAR_TAB%Atualizando principal
			call:CopySimple "%PATH_INSTALL%"
			
			@echo.
			@echo %VAR_TAB%Atualizando importacao
			call:CopySimple "%PATH_UTILITARIO_EXE%"

			@echo.
			@echo %VAR_TAB%Atualizando trunk
			call:CopyBranch "trunk"
			
			@echo.
			@echo %VAR_TAB%Atualizando branches
			call:CopyBranch "2024.03.25"
			call:CopyBranch "2024.01.29"
		)
	) else (
		set "MSG_ERRO=%MSG_MAININI%"&goto:ERRO
	)
) else (
	set "MSG_ERRO=%MSG_AMBIENTE%"&goto:ERRO
)

goto:EXIT

::Functions
::==================================================
:CopyBranch branch
	call:COPIAR %~1 "00000 - Generico"
	call:COPIAR %~1 "00001 - Futura"
	call:COPIAR %~1 "00111 - Campineira"
	call:COPIAR %~1 "00158 - Nelida"
	call:COPIAR %~1 "00171 - AEscolar"
	call:COPIAR %~1 "00178 - MansurMotos"
	call:COPIAR %~1 "00185 - Tendencia"
	call:COPIAR %~1 "00871 - XT"
	call:COPIAR %~1 "01016 - NewGoods"
	call:COPIAR %~1 "01209 - Vicemar"
	call:COPIAR %~1 "02040 - CenterPanosFranquia"
	call:COPIAR %~1 "02220 - NipoCenter"
	call:COPIAR %~1 "03109 - CasaSafari"
	call:COPIAR %~1 "04801 - Dagia"
	call:COPIAR %~1 "00483 - OticaRojo"
	call:COPIAR %~1 "03235 - ParisBijux"
	call:COPIAR %~1 "01284 - ANPP"
	call:COPIAR %~1 "01354 - Sieger"
	call:COPIAR %~1 "03730 - Hand Market"
	call:COPIAR %~1 "00103 - TexPak"
goto:eof

:CopySimple destino
	set "FILE_PROCESSING_ORIGEM=%PATH_ROOT%\%PATH_FUTURAINI%"
	set "FILE_PROCESSING_DESTINO=%~1\%PATH_FUTURAINI%"
	@copy "%FILE_PROCESSING_ORIGEM%" "%FILE_PROCESSING_DESTINO%" /y >nul
	if %errorLevel% neq 0 (
		set "MSG_ERRO=Falha ao copiar o arquivo"
		call:LOG_ERROR "%MSG_ERRO%"
	) else (
		echo %VAR_TAB%%FILE_PROCESSING_DESTINO% copiado
		call:LOG_OK "Arquivo copiado"
	)
goto:eof

:COPIAR branch empresa
	set "FILE_PROCESSING_ORIGEM=%PATH_ROOT%\%PATH_FUTURAINI%"
	set "PATH_EMPRESA=%PATH_FONTES%\%~1\Empresa\%~2"
	set "FILE_PROCESSING_DESTINO=%PATH_EMPRESA%\_EXE\%PATH_FUTURAINI%"

	if exist "%PATH_EMPRESA%" (
		::TODO: Implementar a pasta do tipo de versão (_EXE para 32bit / _EXE64 para 64bit)
		@copy "%FILE_PROCESSING_ORIGEM%" "%FILE_PROCESSING_DESTINO%" /y >nul		
		if %errorLevel% neq 0 (
			set "MSG_ERRO=Falha ao copiar o arquivo"
			call:LOG_ERROR "%MSG_ERRO%"
		) else (
			@echo %VAR_TAB%%FILE_PROCESSING_DESTINO% copiado
			call:LOG_OK "Arquivo copiado"
		)
	)
	
	if not exist "%PATH_EMPRESA%" (
		set "MSG_ERRO=Pasta '%PATH_EMPRESA%' nao encontrada"
		call:LOG_ERROR "%MSG_ERRO%"
	)

goto:eof

:LOG p1 p2
	::p1 = Cabeçalho
	::p2 = Informação
	@echo "%~1" %~2 >> %FILE_LOG%
goto:eof

:LOG_ERROR p1
	::p1 = Mensagem de Erro
	call:LOG "DATA    :" "%date% %time%"
	call:LOG "ORIGEM  :" "%FILE_PROCESSING_ORIGEM%"
	call:LOG "DESTINO :" "%FILE_PROCESSING_DESTINO%"
	call:LOG "ERRO    :" "%~1"
	call:LOG "======================================"
goto:eof

:LOG_OK p1
	::p1 = Mensagem de Sucesso
	call:LOG "DATA    :" "%date% %time%"
	call:LOG "DESTINO :" "%FILE_PROCESSING_DESTINO%"
	call:LOG "SUCESSO :" "%~1"
	call:LOG "======================================"
goto:eof

::Saida
::==================================================
:EXIT
echo.&echo %MSG_OK%&pause>nul
goto:END

:ERRO
call:LOG_ERROR "%MSG_ERRO%"
echo.&echo %MSG_ERRO%...&pause>nul
goto:END

:END
