::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

::VARIAVEIS
::---------
REM Variaveis de Ambiente
@set VAR_PC_AUTORIZADO=PROG19-VM
@set PATH_WORKSPACE=F:\BASES
@set PATH_BACKUP=F:\BACKUP\_BASES\IMPORTACAO
@set PATH_FONTES=F:\BACKUP\_FONTES\IMPORTACAO
@set PATH_CTEMP=C:\_tmp\_imp
@set PATH_FB3=%ProgramFiles%\Firebird\Firebird_3_0
@set FB3_USER=SYSDBA
@set FB3_SENHA=sbofutura
REM Variaveis de Arquivos
@set FDB_DADOS=DADOS.FDB
@set BCK_DADOS=DADOS.BCK
set FILE_IMP_TS_ATUAL=TS_ATUAL.INI
REM Variaveis de Aplicativo
@set EXE_GBAK=%PATH_FB3%\GBAK.EXE
@set EXE_7ZIP=%ProgramFiles%\7-Zip\7z.exe
REM Variaveis de Texto
@set MSG_OK=Workspace limpo
@set MSG_ERRORDEFAULT=Nao foi possivel limpar o workspace
@set MSG_ERRO=Erro inesperado
@set MSG_AMBIENTE=Este script nao pode ser executado fora do ambiente
@set MSG_INICIAL=Iniciando limpeza do Workspace

::MAIN
::--------------------------------------------------------------------------------
REM Inicio do Main
@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (
	@echo %MSG_INICIAL%...
	@echo.
	SETLOCAL
	@for /f "tokens=*" %%d in ('dir /o:-d /t:c /b /s /a:d "%PATH_WORKSPACE%\DESTINO"') do (
		set PATH_ATUAL=%%d
		call:getPath PATH_ATUAL 3
		set PATH_IMP_TS_ATUAL=%PATH_WORKSPACE%\!getPath_return!\%FILE_IMP_TS_ATUAL%
		set /p VAR_TS_ATUAL=<!PATH_IMP_TS_ATUAL!
		set PATH_IMPORTACAO=%PATH_WORKSPACE%\!getPath_return!\!VAR_TS_ATUAL!
		@set PATH_ORIGEM=!PATH_IMPORTACAO!\ORIGEM
		@set PATH_DESTINO=!PATH_IMPORTACAO!\DESTINO
		@set PATH_DOCUMENTOS=!PATH_IMPORTACAO!\DOCUMENTOS
		@set PATH_PRINTS=!PATH_IMPORTACAO!\PRINTS
		call:getImportacaoID "!getPath_return!"
		Rem Debug -----------------------------------------------------------------
			Rem echo !getPath_return!
			Rem echo !getImportacaoID_return!
			Rem pause
			Rem goto:end
		Rem Debug -----------------------------------------------------------------
		@set IMP_ID=!getImportacaoID_return!
		@set PATH_CTEMPID=%PATH_CTEMP%\!IMP_ID!
		@echo ----------------------------------------------------------------------
		@echo Fazendo Backup de !getPath_return!...
		if exist "!PATH_CTEMPID!" call:Deltree !PATH_CTEMPID! >nul
		@md "!PATH_CTEMPID!" >nul
		@echo - Compactando DESTINO_DADOS.FDB...
			if exist "!PATH_CTEMPID!\DESTINO_%BCK_DADOS%" del "!PATH_CTEMPID!\DESTINO_%BCK_DADOS%"
			if exist "!PATH_CTEMPID!\DESTINO_%FDB_DADOS%" del "!PATH_CTEMPID!\DESTINO_%FDB_DADOS%"
			@copy "!PATH_DESTINO!\%FDB_DADOS%" "!PATH_CTEMPID!\DESTINO_%FDB_DADOS%" >nul
			@"%EXE_GBAK%" -b -user %FB3_USER% -pass %FB3_SENHA% "!PATH_CTEMPID!\DESTINO_%FDB_DADOS%" "!PATH_CTEMPID!\DESTINO_%BCK_DADOS%"
			if %ERRORLEVEL% NEQ 0 goto:ERROR
		@echo - Compactando ORIGEM_DADOS.FDB...
			if exist "!PATH_CTEMPID!\ORIGEM_%BCK_DADOS%" del "!PATH_CTEMPID!\ORIGEM_%BCK_DADOS%"
			if exist "!PATH_CTEMPID!\ORIGEM_%FDB_DADOS%" del "!PATH_CTEMPID!\ORIGEM_%FDB_DADOS%"
			@copy "!PATH_ORIGEM!\%FDB_DADOS%" "!PATH_CTEMPID!\ORIGEM_%FDB_DADOS%" >nul
			@"%EXE_GBAK%" -b -user %FB3_USER% -pass %FB3_SENHA% "!PATH_CTEMPID!\ORIGEM_%FDB_DADOS%" "!PATH_CTEMPID!\ORIGEM_%BCK_DADOS%"
			if %ERRORLEVEL% NEQ 0 goto:ERROR
		@echo - Compactando IMP_ID.ZIP...
			if exist "!PATH_CTEMPID!\!IMP_ID!.ZIP" del "!PATH_CTEMPID!\!IMP_ID!.ZIP"
			@echo -- "!PATH_CTEMPID!\DESTINO_%BCK_DADOS%"
				@"%EXE_7ZIP%" a -tzip "!PATH_CTEMPID!\!IMP_ID!.ZIP" "!PATH_CTEMPID!\DESTINO_%BCK_DADOS%" -y >nul
				if %ERRORLEVEL% NEQ 0 goto:ERROR
			@echo -- "!PATH_CTEMPID!\ORIGEM_%BCK_DADOS%"
				@"%EXE_7ZIP%" a -tzip "!PATH_CTEMPID!\!IMP_ID!.ZIP" "!PATH_CTEMPID!\ORIGEM_%BCK_DADOS%" -y >nul
				if %ERRORLEVEL% NEQ 0 goto:ERROR
			@echo -- "!PATH_DOCUMENTOS!\*.*"
				@"%EXE_7ZIP%" a -tzip "!PATH_CTEMPID!\!IMP_ID!.ZIP" "!PATH_DOCUMENTOS!\*.*" -y >nul
				if %ERRORLEVEL% NEQ 0 goto:ERROR
			rem Nao tem mais a pasta PRINTS
			rem @echo -- "!PATH_PRINTS!\*.*"
			rem @"%EXE_7ZIP%" a -tzip "!PATH_CTEMPID!\!IMP_ID!.ZIP" "!PATH_PRINTS!\*.*" -y >nul
			rem if %ERRORLEVEL% NEQ 0 goto:ERROR
			@copy "!PATH_CTEMPID!\!IMP_ID!.ZIP" "%PATH_BACKUP%\!IMP_ID!.ZIP" >nul
			@echo -- Scripts
				@"%EXE_7ZIP%" a -tzip "!PATH_CTEMPID!\!IMP_ID!_SCRIPTS.ZIP" "!PATH_IMPORTACAO!\SCRIPTS\*.*" -y >nul
				if %ERRORLEVEL% NEQ 0 goto:ERROR
				@copy "!PATH_CTEMPID!\!IMP_ID!_SCRIPTS.ZIP" "%PATH_FONTES%\SCRIPTS\!IMP_ID!.ZIP" /y >nul
		rem Separar limpeza dos Temps para alguns dias depois
		rem @echo - Limpando Temp...
			rem if exist "!PATH_CTEMPID!\DESTINO_%BCK_DADOS%" del "!PATH_CTEMPID!\DESTINO_%BCK_DADOS%"
			rem if exist "!PATH_CTEMPID!\DESTINO_%FDB_DADOS%" del "!PATH_CTEMPID!\DESTINO_%FDB_DADOS%"
			rem if exist "!PATH_CTEMPID!\ORIGEM_%BCK_DADOS%" del "!PATH_CTEMPID!\ORIGEM_%BCK_DADOS%"
			rem if exist "!PATH_CTEMPID!\ORIGEM_%FDB_DADOS%" del "!PATH_CTEMPID!\ORIGEM_%FDB_DADOS%"
			rem if exist "!PATH_CTEMPID!\!IMP_ID!.ZIP" del "!PATH_CTEMPID!\!IMP_ID!.ZIP"
			rem if exist "!PATH_CTEMPID!\!IMP_ID!_SCRIPTS.ZIP" del "!PATH_CTEMPID!\!IMP_ID!_SCRIPTS.ZIP"
		rem @echo.echo Limpar arquivos da Workspace Bases agora...&pause>nul
		@echo - Limpando Bases...
			@set PATH_REMOVE="%PATH_WORKSPACE%\!getPath_return!"
			echo !PATH_REMOVE!
			rem call:Deltree !PATH_REMOVE!
	)
	ENDLOCAL
) else (
	@set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
goto:end

::FUNCOES
::-------
:getImportacaoID vPath
SETLOCAL
for /f "tokens=1 delims= " %%i in ("%~1") do set "VAR_ID=%%i"
( ENDLOCAL
	set getImportacaoID_return=%VAR_ID%
)
goto:eof

:Deltree Caminho
SETLOCAL
@if "%~1"=="" goto:eof
	@pushd "%~1" >nul
	@del /f /q /s "%~1\*.*" >nul
	@cd \
	@rd /s /q "%~1" >nul
	@if exist "%~1" rd /s /q "%~1" >nul
	@popd
ENDLOCAL
goto:eof

:getPath ThePath Part
SETLOCAL
for /f "tokens=1,2,3,4 delims=\" %%a in ("!%~1!") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"
( ENDLOCAL
	if %~2 == 1 set getPath_return=%PASTA_ATUAL[1]%
	if %~2 == 2 set getPath_return=%PASTA_ATUAL[2]%
	if %~2 == 3 set getPath_return=%PASTA_ATUAL[3]%
	if %~2 == 4 set getPath_return=%PASTA_ATUAL[4]%
)
goto:eof

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

:ERROR
@echo.&echo %MGS_ERRODEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END


:END