::CABECALHO
::---------
@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul

::VARIAVEIS
::---------
REM Variaveis de Texto
set MSG_AMBIENTE=Este script nao pode ser executado fora do ambiente
set MSG_INICIAL=Configurando arquivos Futura.ini
set MSG_OK=Paths configurados
set MSG_ERRORDEFAULT=Nao foi possivel definir paths de ambiente
set MSG_ERRO=Erro inesperado
REM Variaveis de Ambiente
@set VAR_PC_AUTORIZADO=PROG19-VM
set PATH_BASES=C:\_tmp\_bases\_importacao
REM set PATH_BASES_FISICA=F:\BASES
set PATH_BASES_FISICA=C:\_tmp\_bases\_importacao
set PATH_CTEMP=C:\_tmp\_imp
REM set PATH_FONTES=C:\_Fontes\Utilitarios\Importacao\_DelphiXe10
set PATH_FONTES=C:\_Fontes\Importacao_DelphiXe10
set PATH_PROJETO=UTILITARIOS\Sistema
set PATH_FB3=%ProgramFiles%\Firebird\Firebird_3_0
set FB3_USER=SYSDBA
set FB3_SENHA=sbofutura
set PARAM_ORIGEM=%~1
set PARAM_DESTINO=%~2
set "VAR_TAB=    "

if "%PARAM_ORIGEM%"=="" cls

REM Variaveis de Caminho
REM call:getPath 1
REM set ALIAS_IMPORTACAO=%getPath_return%

set ALIAS_IMPORTACAO=%~3
set PATH_IMPORTACAO=%PATH_BASES%\%ALIAS_IMPORTACAO%
set PATH_IMPORTACAO_F=%PATH_BASES_FISICA%\%ALIAS_IMPORTACAO%
call:getImportacaoID "%ALIAS_IMPORTACAO%"

set VAR_IMPORTACAO_ID=%getImportacaoID_return%
REM call:getPath 5
set IMPORTACAO_INSTANCIA=%~4
set PATH_WORKSPACE=%PATH_IMPORTACAO%\%IMPORTACAO_INSTANCIA%
set PATH_WORKSPACE_F=%PATH_IMPORTACAO_F%\%IMPORTACAO_INSTANCIA%
set PATH_ORIGEM=%PATH_WORKSPACE_F%\ORIGEM
set PATH_DESTINO=%PATH_WORKSPACE_F%\DESTINO
set PATH_SCRIPTS=%PATH_WORKSPACE%\SCRIPTS
REM Variaveis de Arquivo
set FILE_DESTINO_LIMPA=%PATH_DESTINO%\LIMPA.BCK
set FILE_CTEMP_LIMPA=%PATH_CTEMP%\LIMPA.BCK
set FILE_CTEMP_DADOS=%PATH_CTEMP%\TEMP.FDB
set FILE_DESTINO_DADOS=%PATH_DESTINO%\DADOS.FDB
set FILE_FONTE_ATUAL=%PATH_FONTES%\%ALIAS_IMPORTACAO%\%PATH_PROJETO%
REM Variaveis de Aplicativo
set EXE_GBAK=%PATH_FB3%\GBAK.EXE

::INI
::----------------------------------------------------------------------
REM set INI_FONTES=C:\_Fontes\Utilitarios\Importacao\_DelphiXe10
REM set INI_FONTES=C:\_Fontes\Importacao
set INI_FONTES=C:\_Fontes\Importacao_DelphiXe10
set INI_TRUNK=C:\_Fontes\trunk\Empresa\00000 - Generico\_EXE
set INI_UTILITARIO=%INI_FONTES%\%ALIAS_IMPORTACAO%\_EXE\FUTURA.INI
set INI_FUTURASERVER=%INI_TRUNK%\FUTURA.INI
set INI_IMPORTACAO=C:\FUTURA\IMPORTACAO.INI
set INI_IMPORTACAO_BACKUP=C:\FUTURA\BACKUP_IMPORTACAO.INI
set INI_IMPORTACAO_ORIGEM=%PATH_ORIGEM%\DADOS.FDB
::----------------------------------------------------------------------

::MAIN
::----------------------------------------------------------------------
@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (
	@echo %MSG_INICIAL%...
	set DataAmericana_return=...
	call:DataAmericana
	set HoraAmericana_return=...
	call:HoraAmericana

	REM O Futura.ini da importacao eh o que vai ser carregado com a execucao do utilitario
	@echo %VAR_TAB%- Montando Futura.ini da Importacao (ORIGEM)
	if exist "%INI_IMPORTACAO%" (
		@copy "%INI_IMPORTACAO%" "%INI_IMPORTACAO_BACKUP%_!DataAmericana_return!!HoraAmericana_return!" >nul
		@del "%INI_IMPORTACAO%"
	) else (
		@set MSG_ERRO="%INI_IMPORTACAO%" nao existe!
		goto:ERROR
	)
	> "%INI_IMPORTACAO%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		@echo [DADOS]
		@echo IMPORTACAO_ID=%VAR_IMPORTACAO_ID%
		@echo IP=prog19-vm
		REM VERIFICAR PORTAS
		@echo Porta=3050
		if "!PARAM_ORIGEM:~0,1!"=="F" (
			@echo ALIAS=!PARAM_ORIGEM!\DADOS.FDB
		) else (
			@echo ALIAS=%INI_IMPORTACAO_ORIGEM%
		)
		@echo SENHA=%FB3_SENHA%
		@echo USUARIO=SYSDBA
		ENDLOCAL
	)
	Rem Copiar para HadsTemp Utilitario Local
	@del "F:\BACKUP\Temp\_pas\HadsTemp\_EXE\FUTURA.INI"
	@copy "%INI_IMPORTACAO%" "F:\BACKUP\Temp\_pas\HadsTemp\_EXE\FUTURA.INI" >nul
	
	
	REM O Futura.ini do utilitario é o que vai pro backup do SVN
	@echo %VAR_TAB%- Montando Futura.ini do Unitilitario (DESTINO)
	if not exist "%INI_FONTES%\%ALIAS_IMPORTACAO%\_EXE" (
		@md "%INI_FONTES%\%ALIAS_IMPORTACAO%\_EXE!" >nul
	)
	if exist "%INI_UTILITARIO%" (

		@copy "%INI_UTILITARIO%" "%INI_UTILITARIO%_!DataAmericana_return!!HoraAmericana_return!" >nul
		@del "%INI_UTILITARIO%"
	)
	> "%INI_UTILITARIO%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		@echo [BASE_01]
		@echo IMPORTACAO_ID=%VAR_IMPORTACAO_ID%
		@echo DADOS_ALIAS=DADOS_DESTINO
		@echo DADOS_IP=prog19-vm
		if "!PARAM_DESTINO:~0,1!"=="F" (
			@echo DADOS_PATH=!PARAM_DESTINO!\DADOS.FDB
		) else (
			@echo DADOS_PATH=%FILE_DESTINO_DADOS%
		)
		@echo FIREBIRD_OPCAO=%FB3_SENHA%
		ENDLOCAL
	)
	
	REM O Futura.ini do FuturaServer quando abrir o sistema pra testar na base da importacao
	@echo %VAR_TAB%- Montando Futura.ini do Futura_Server (DESTINO)
	if exist "%INI_FUTURASERVER%" (
		@copy "%INI_FUTURASERVER%" "%INI_FUTURASERVER%_!DataAmericana_return!!HoraAmericana_return!" >nul
		@del "%INI_FUTURASERVER%"
	)
	> "%INI_FUTURASERVER%" (
		SETLOCAL ENABLEDELAYEDEXPANSION
		@echo [BASE_01]
		@echo IMPORTACAO_ID=%VAR_IMPORTACAO_ID%
		@echo FIREBIRD_PORTA=3050
		@echo DADOS_ALIAS=DADOS_DESTINO
		@echo DADOS_IP=prog19-vm
		if "!PARAM_DESTINO:~0,1!"=="F" (
			@echo DADOS_PATH=!PARAM_DESTINO!\DADOS.FDB
		) else (
			@echo DADOS_PATH=%FILE_DESTINO_DADOS%
		)
		@echo BACKUP_PATH=C:\Futura\Backup\
		@echo FIREBIRD_OPCAO=%FB3_SENHA%
		ENDLOCAL
	)
) else (
	::--------------------------------------------------
	::--------------------------------------------------
	Rem verificar por que está saindo com erro
	::--------------------------------------------------
	::--------------------------------------------------

	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
if not "!PARAM_ORIGEM:~0,1!"=="F" (
	explorer "%FILE_FONTE_ATUAL%"
	rem Saida para grupo skype
	@echo ----------------------------------
	@echo /me iniciou a importação ID !ALIAS_IMPORTACAO:~,4! |clip
	@pause>nul
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
@set MSG_ERRO="%FILE_DESTINO_DADOS%" j� existe
goto:ERROR

:ERROR
@echo.&echo %MSG_ERRORDEFAULT%&echo.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%! &pause>nul&goto:END

::FUNCOES
::-------
:debug
::----------
@echo on
@echo "%~1"
@echo.
@pause
@echo off
goto:END
::----------

::----------
:debug_1
	::--------------------
	:: 13812 - FLOSE E REIMBERG MATERIAIS PARA CONSTRUCAO LTDA
	echo INI _Exe: "%INI_FONTES%\%ALIAS_IMPORTACAO%\_EXE"
	echo INI Utilitario: "%INI_UTILITARIO%"
	echo INI Backup: "%INI_UTILITARIO%_!DataAmericana_return!!HoraAmericana_return!"
	pause
	::--------------------	
goto:END
::----------

:getImportacaoID vPath
SETLOCAL
for /f "tokens=1 delims= " %%i in ("%~1") do set "VAR_ID=%%i"
(ENDLOCAL
	set getImportacaoID_return=%VAR_ID%
)
@goto:eof

:getPath
SETLOCAL
for /f "tokens=1 delims=?" %%a in ("%~p0") do set "PARENTESIS=%%a"
set FullPathLen=...
call:strLen PARENTESIS FullPathLen
for /f "tokens=1 delims=(" %%a in ("%~p0") do set "PARENTESIS=%%a"
set PartLen=...
call:strLen PARENTESIS PartLen
Rem Se FullPathLen != PartLen significa que tem parentesis na string do path
if %FullPathLen% NEQ %PartLen% (
	@set MSG_ERRO=Este caminho "%~p0" tem o caracter inv�lido "("!
	goto:ERROR
)
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
:$created 20081122
:$changed 20101116
:$categories StringOperation
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