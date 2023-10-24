::CABECALHO
::---------
@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul

::VARIAVEIS
::---------
REM Variaveis de Ambiente
set PATH_BASES=Z:\BASES
set PATH_CTEMP=C:\TEMP
set PATH_FB3=%ProgramFiles%\Firebird\Firebird_3_0
set FB3_USER=SYSDBA
set FB3_SENHA=masterkey
set PARAM_ORIGEM=%~1
set PARAM_DESTINO=%~2

if "%PARAM_ORIGEM%"=="" cls

REM Variaveis de Caminho
call:getPath 2
set ALIAS_IMPORTACAO=%getPath_return%
set PATH_IMPORTACAO=%PATH_BASES%\%getPath_return%
call:getPath 3
set PATH_WORKSPACE=%PATH_IMPORTACAO%\%getPath_return%

set PATH_ORIGEM=%PATH_WORKSPACE%\ORIGEM
set PATH_DESTINO=%PATH_WORKSPACE%\DESTINO
set PATH_SCRIPTS=%PATH_WORKSPACE%\SCRIPTS
REM Variaveis de Arquivo
set FILE_DESTINO_LIMPA=%PATH_DESTINO%\LIMPA.BCK
set FILE_CTEMP_LIMPA=%PATH_CTEMP%\LIMPA.BCK
set FILE_CTEMP_DADOS=%PATH_CTEMP%\TEMP.FDB
set FILE_DESTINO_DADOS=%PATH_DESTINO%\DADOS.FDB

REM Variaveis de Aplicativo
set EXE_GBAK=%PATH_FB3%\GBAK.EXE
REM Variaveis de Texto
set MSG_AMBIENTE=Este script nÃ£o pode ser executado fora do ambiente
set MSG_INICIAL=Configurando arquivos Futura.ini
set MSG_OK=Paths configurados
set MSG_ERRORDEFAULT= NÃ£o foi possÃ­vel restaurar
set MSG_ERRO=Erro inesperado

::INI
::----------------------------------------------------------------------
set INI_FONTES=C:\_Fontes\Utilitarios\Importacao\_DelphiXe10
set INI_TRUNK=C:\_Fontes\trunk\Empresa\00000 - Generico\_EXE
set INI_UTILITARIO=%INI_FONTES%\%ALIAS_IMPORTACAO%\_EXE\FUTURA.INI
set INI_FUTURASERVER=%INI_TRUNK%\FUTURA.INI
set INI_IMPORTACAO=C:\FUTURA\IMPORTACAO.INI
set INI_IMPORTACAO_BACKUP=C:\FUTURA\BACKUP_IMPORTACAO.INI
set INI_IMPORTACAO_ORIGEM=%PATH_ORIGEM%\DADOS.FDB

::----------------------------------------------------------------------

::MAIN
::----------------------------------------------------------------------
if %COMPUTERNAME% EQU DESKTOP-4A54RRC (
	@echo %MSG_INICIAL%...
	set DataAmericana_return=...
	call:DataAmericana
	set HoraAmericana_return=...
	call:HoraAmericana
	REM Monta Futura.ini da Importação (ORIGEM)
	if exist "%INI_IMPORTACAO%" (
		@copy "%INI_IMPORTACAO%" "%INI_IMPORTACAO_BACKUP%_!DataAmericana_return!!HoraAmericana_return!" >nul
		@del "%INI_IMPORTACAO%"
	)
	> "%INI_IMPORTACAO%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		@echo [DADOS]
		@echo IMPORTACAO_ID=%getPath_return:~0,4%
		@echo IP=PROGRAMACAO19
		REM VERIFICAR PORTAS
		@echo Porta=5432
		if "!PARAM_ORIGEM:~0,1!"=="Z" (
			@echo ALIAS=!PARAM_ORIGEM!\DADOS.FDB
		) else (
			@echo ALIAS=%INI_IMPORTACAO_ORIGEM%
		)
		@echo SENHA=§³¡ ¯¢©¯›
		@echo USUARIO=SYSDBA
		ENDLOCAL
	)
	REM Monta Futura.ini do Unitilitario (DESTINO)
	if exist "%INI_UTILITARIO%" (
		@copy "%INI_UTILITARIO%" "%INI_UTILITARIO%_!DataAmericana_return!!HoraAmericana_return!" >nul
		@del "%INI_UTILITARIO%"
	)
	> "%INI_UTILITARIO%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		@echo [BASE_01]
		@echo IMPORTACAO_ID=%getPath_return:~0,4%
		@echo DADOS_ALIAS=DADOS
		@echo DADOS_IP=programacao19.futura.sbo
		if "!PARAM_DESTINO:~0,1!"=="Z" (
			@echo DADOS_PATH=!PARAM_DESTINO!\DADOS.FDB
		) else (
			@echo DADOS_PATH=%FILE_DESTINO_DADOS%
		)
		@echo FIREBIRD_OPCAO=masterkey
		ENDLOCAL
	)
	REM Monta Futura.ini do Futura_Server (DESTINO)
	if exist "%INI_FUTURASERVER%" (
		@copy "%INI_FUTURASERVER%" "%INI_FUTURASERVER%_!DataAmericana_return!!HoraAmericana_return!" >nul
		@del "%INI_FUTURASERVER%"
	)
	> "%INI_FUTURASERVER%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		@echo [BASE_01]
		@echo IMPORTACAO_ID=%getPath_return:~0,4%
		@echo FIREBIRD_PORTA=3050
		@echo DADOS_ALIAS=GENERICO
		@echo DADOS_IP=programacao19.futura.sbo
		if "!PARAM_DESTINO:~0,1!"=="Z" (
			@echo DADOS_PATH=!PARAM_DESTINO!\DADOS.FDB
		) else (
			@echo DADOS_PATH=%FILE_DESTINO_DADOS%
		)
		@echo BACKUP_PATH= C:\Futura\Backup\
		@echo FIREBIRD_OPCAO=masterkey
		ENDLOCAL
	)
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
goto:EXIT

::EXIT
::----------------------------------------------------------------------
:EXIT
if "%PARAM_ORIGEM%"=="" @echo.&echo %MSG_OK%.&timeout 10&goto:END
goto:end

::ERROR
::-----
:DadosExiste
@set MSG_ERRO="%FILE_DESTINO_DADOS%" já existe
goto:ERROR

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%! &pause>nul&goto:END

::FUNCOES
::-------
:getPath
SETLOCAL
for /f "tokens=1,2,3,4 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"
(ENDLOCAL
	if %~1 == 1 set getPath_return=%PASTA_ATUAL[1]%
	if %~1 == 2 set getPath_return=%PASTA_ATUAL[2]%
	if %~1 == 3 set getPath_return=%PASTA_ATUAL[3]%
	if %~1 == 4 set getPath_return=%PASTA_ATUAL[4]%
)
@goto:eof

:DeletaCTemp
del "%FILE_CTEMP_DADOS%"
@goto:eof

:DataAmericana
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
if %DIA% EQU 08 set DIA=8
if %DIA% EQU 09 set DIA=9
::set /a DIA=%DIA%-1
( SETLOCAL
	set TAMANHO=...
	call:strLen DIA TAMANHO
)
( ENDLOCAL
	IF %TAMANHO% LSS 2 SET "DIA=0%DIA%"
)
set "DataAmericana_return=%ANO%%MES%%DIA%"
goto:eof

:HoraAmericana
set HORA=%time:~0,2%
set MINUTO=%time:~3,2%
set SEGUNDO=%time:~6,2%
( SETLOCAL
	set TAMANHO=...
	call:strLen HORA TAMANHO
)
( ENDLOCAL
	if %TAMANHO% LSS 2 (
		set "HORA=0%HORA%"
	) else (
		if "%HORA:~0,1%" EQU " " (
			set "HORA=0%HORA:~1,1%"
		)
	)
)
set "HoraAmericana_return=%HORA%%MINUTO%%SEGUNDO%"
goto:eof

:strLen string len -- returns the length of a string
::                 -- string [in]  - variable name containing the string being measured for length
::                 -- len    [out] - variable to be used to return the string length
:: Many thanks to 'sowgtsoi', but also 'jeb' and 'amel27' dostips forum users helped making this short and efficient
:$created 20081122 :$changed 20101116 :$categories StringOperation
:$source https://www.dostips.com
(   SETLOCAL ENABLEDELAYEDEXPANSION
    set "str=A!%~1!"&rem keep the A up front to ensure we get the length and not the upper bound
                     rem it also avoids trouble in case of empty string
    set "len=0"
    for /L %%A in (12,-1,0) do (
        set /a "len|=1<<%%A"
        for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
    )
)
( ENDLOCAL & REM RETURN VALUES
    IF "%~2" NEQ "" SET /a %~2=%len%
)
goto:eof

:END
::@pause