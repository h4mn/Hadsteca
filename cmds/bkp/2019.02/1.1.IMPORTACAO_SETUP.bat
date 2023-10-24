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
set PATH_WORKSPACE=Z:\BASES
set PATH_CTEMP=C:\TEMP
set PATH_DEV=Z:\DEV
set PATH_SCRIPTS=Z:\DEV\MODELO\SCRIPTS
set PATH_FONTES=C:\_Fontes\Utilitarios\Importacao\_DelphiXe10
set PATH_FB3=%ProgramFiles%\Firebird\Firebird_3_0
set PATH_NOVAS=I:\BasesNovas
set PATH_LIMPA=R:\17 - BaseLimpa
set FB3_USER=SYSDBA
set FB3_SENHA=masterkey
set "VAR_TAB=    "
set VAR_DB_EXTENSAO=FDB
rem Arquivos
set FILE_FDB=DADOS.FDB
set FILE_ZIP=DADOS.ZIP
set FILE_BCK=DADOS.BCK
set FILE_BCK_LIMPA=LIMPA.BCK
set FILE_CTEMP_BCK=DADOS_NOVA.BKC
set FILE_CTEMP_NOVA=DADOS_NOVA.FDB
set FILE_CTEMP_ORIGEM=DADOS_ORIGEM.FDB
call:getLimpa N
set FILE_DELPHI=C:\Program Files (x86)\Embarcadero\Studio\18.0\bin\bds.exe
set FILE_EXE_GBAK=%PATH_FB3%\GBAK.EXE
set FILE_EXE_ISQL=%PATH_FB3%\ISQL.EXE
set FILE_EXE_7ZIP=%ProgramFiles%\7-Zip\7z.EXE
set FILE_IMP_ANTERIOR=%PATH_DEV%\ANTERIOR.INI
set FILE_IMP_LOG=%PATH_DEV%\IMPORTACAO.LOG
set FILE_IMP_TS_ATUAL=TS_ATUAL.INI
set FILE_BCK_TEMP=%PATH_CTEMP%\%FILE_CTEMP_BCK%
set FILE_DADOSTEMP=%PATH_CTEMP%\%FILE_CTEMP_NOVA%
set PATH_FILE_DADOSTEMP_ORIGEM=%PATH_CTEMP%\%FILE_CTEMP_ORIGEM%
rem Mensagens
set MSG_TITLE=Configurando Importação
set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
set MSG_INICIAL=Iniciando Setup da Importação
set MSG_INPUT=Entre os dados desta Importação
set MSG_INPUT_ALIAS=ALIAS
set MSG_INPUT_DATA=DATA
set MSG_INPUT_PASTA=PASTA
set MSG_ERRO_NOEXIST=Pasta\Arquivo não existe
set MSG_ERRO_NOINPUT=Entrada indevida
set MSG_ERRO=Erro inesperado
set MSG_ERRORDEFAULT=Não foi possível fazer o Setup
set MSG_OK= Setup completado
::MAIN
::----------------------------------------------------------------------
if %COMPUTERNAME% EQU DESKTOP-4A54RRC (
	@echo ==================================================
	title %MSG_TITLE%
	@echo %MSG_INPUT%
	rem UserInput
	set /p _IMP_ALIAS="%MSG_INPUT_ALIAS%: "||set _IMP_ALIAS="NULO"
	if "!_IMP_ALIAS!" NEQ "NULO" (
		set PATH_ALIAS=%PATH_NOVAS%\!_IMP_ALIAS!
		if exist "!PATH_ALIAS!" (
			title %MSG_TITLE%: !_IMP_ALIAS!
			rem Bloco captura pasta data
			rem --------------------------------------------------
			set "COUNTER="
			for /f "tokens=*" %%p in ('dir /o:-d /t:c /b /a:d "!PATH_ALIAS!"') do (
				set /a "COUNTER+=1"
				echo %VAR_TAB%!COUNTER!.%%p
			)
			set /p _IMP_PASTA_ESCOLHA=">"||set _IMP_PASTA_ESCOLHA=NULO
			set "COUNTER="
			for /f "tokens=*" %%p in ('dir /o:-d /t:c /b /a:d "!PATH_ALIAS!"') do (
				set /a "COUNTER+=1"
				if "!COUNTER!"=="!_IMP_PASTA_ESCOLHA!" (
					set _IMP_DATA=%%p||set _IMP_DATA=NULO
				)
			)
			echo %MSG_INPUT_PASTA%: !_IMP_DATA!
			rem --------------------------------------------------
			if "!_IMP_DATA!" NEQ "NULO" (
				set PATH_DATA=!PATH_ALIAS!\!_IMP_DATA!
				if exist "!PATH_DATA!" (
					call:ImportacaoAnterior
					set _IMP_ANTERIOR=!ImportacaoAnterior_return!
					@echo --------------------------------------------------
					@echo ATUAL    : !_IMP_ALIAS!
					@echo DATA     : !_IMP_DATA!
					@echo ANTERIOR : !_IMP_ANTERIOR!
					@echo --------------------------------------------------
					call:DataAmericana S
					call:HoraAmericana S
					set VAR_AGORA=!DataAmericana_return!_!HoraAmericana_return!
					set PATH_IMPORTACAO=%PATH_WORKSPACE%\!_IMP_ALIAS!\!_IMP_DATA!_!VAR_AGORA!
					set PATH_IMP_TS_ATUAL=!PATH_WORKSPACE!\!_IMP_ALIAS!\%FILE_IMP_TS_ATUAL%
					set PATH_IMP_SCRIPTS=!PATH_IMPORTACAO!\SCRIPTS
					set PATH_FONTE_ANTERIOR=%PATH_FONTES%\!_IMP_ANTERIOR!\UTILITARIOS
					set PATH_FONTE_ANTERIOR_EXE=%PATH_FONTES%\!_IMP_ANTERIOR!\_EXE
					set PATH_FONTE_ATUAL=%PATH_FONTES%\!_IMP_ALIAS!\UTILITARIOS
					set PATH_FONTE_ATUAL_EXE=%PATH_FONTES%\!_IMP_ALIAS!\_EXE
					set PATH_ORIGEM_DOCUMENTOS=!PATH_NOVAS!\!_IMP_ALIAS!\*.*
					set PATH_ORIGEM_PRINTS=!PATH_NOVAS!\!_IMP_ALIAS!\PRINTS
					set PATH_ORIGEM_DADOS_ZIP=!PATH_NOVAS!\!_IMP_ALIAS!\!_IMP_DATA!\%FILE_ZIP%
					set PATH_ORIGEM_DADOS_BCK=!PATH_IMPORTACAO!\ORIGEM\%FILE_BCK%
					set PATH_ORIGEM_DADOS_FDB=!PATH_IMPORTACAO!\ORIGEM\%FILE_FDB%
					set PATH_ORIGEM_SQLNEWDB=!PATH_IMPORTACAO!\SCRIPTS\1.1.NOVA_ORIGEM.SQL
					set PATH_DESTINO_LIMPA=!PATH_IMPORTACAO!\DESTINO\%FILE_LIMPA_EXE%
					set PATH_DESTINO_LIMPA_BCK=!PATH_IMPORTACAO!\DESTINO\%FILE_BCK_LIMPA%
					set PATH_DESTINO_DADOS_FDB=!PATH_IMPORTACAO!\DESTINO\%FILE_FDB%
					set PATH_PROJETO_ATUAL=!PATH_FONTE_ATUAL!\Sistema\Project.groupproj
					@echo %MSG_INICIAL%...
					rem Pasta
					@echo %VAR_TAB%- Criando pastas
					@md "!PATH_IMPORTACAO!" >nul
					call:TimestampAtual
					rem Fontes
					if not exist "!PATH_FONTE_ATUAL!" (
						@md "!PATH_FONTE_ATUAL!" >nul
						@md "!PATH_FONTE_ATUAL_EXE!" >nul
						@echo %VAR_TAB%- Copiando fontes
						@xcopy "!PATH_FONTE_ANTERIOR!" "!PATH_FONTE_ATUAL!" /e /y >nul
						@copy "!PATH_FONTE_ANTERIOR_EXE!\FUTURA.INI" "!PATH_FONTE_ATUAL_EXE!\FUTURA.INI" >nul
					)
					rem Modelos
					@echo %VAR_TAB%- Copiando modelos
					@md "!PATH_IMPORTACAO!\DESTINO" >nul
					@md "!PATH_IMPORTACAO!\DOCUMENTOS" >nul
					@md "!PATH_IMPORTACAO!\ORIGEM" >nul
					@md "!PATH_IMPORTACAO!\SCRIPTS" >nul
					@xcopy "!PATH_ORIGEM_DOCUMENTOS!" "!PATH_IMPORTACAO!\DOCUMENTOS" /y >nul
					if exist "!PATH_ORIGEM_PRINTS!" (
						@xcopy "!PATH_ORIGEM_PRINTS!" "!PATH_IMPORTACAO!\DOCUMENTOS" /s /y >nul
					)
					@xcopy "%PATH_SCRIPTS%" "!PATH_IMP_SCRIPTS!" /s /y >nul
					rem Base_Origem
					rem A base de origem é aquela a ser importada
					rem --------------------------------------------------
					@echo %VAR_TAB%- Extraindo base origem
					@echo @copy "!PATH_ORIGEM_DADOS_ZIP!" "!PATH_IMPORTACAO!\ORIGEM\%FILE_ZIP%" /y >nul
					@copy "!PATH_ORIGEM_DADOS_ZIP!" "!PATH_IMPORTACAO!\ORIGEM\%FILE_ZIP%" /y >nul
					@pushd "!PATH_IMPORTACAO!\ORIGEM"
					@"%FILE_EXE_7ZIP%" e "!PATH_IMPORTACAO!\ORIGEM\!FILE_ZIP!" -y -sdel >nul
					if "%ERRORLEVEL%"=="0" (
						if exist "!PATH_IMPORTACAO!\ORIGEM\!FILE_ZIP!" del "!PATH_IMPORTACAO!\ORIGEM\!FILE_ZIP!" >nul
					)
					if exist "!PATH_ORIGEM_DADOS_BCK!" (
						@"%FILE_EXE_GBAK%" -c -user %FB3_USER% -pass %FB3_SENHA% "%PATH_ORIGEM_DADOS_BCK%" "%PATH_ORIGEM_DADOS_FDB%"
					) else (
						@for /f "tokens=*" %%d in ('dir /o:s /t:c /b /s "!PATH_IMPORTACAO!\ORIGEM"') do (
							set VAR_FILE=%%d
						)
						call:GetExtension "!VAR_FILE!"
						set VAR_DB_EXTENSAO=!GetExtension_return:~1!
						@if exist "%FILE_DADOSTEMP%" del "%FILE_DADOSTEMP%"
						@"%FILE_EXE_ISQL%" -input "!PATH_ORIGEM_SQLNEWDB!" -quiet >nul
						@if %ERRORLEVEL% NEQ 0 goto:ERROR
						@copy "%FILE_DADOSTEMP%" "!PATH_ORIGEM_DADOS_FDB!" >nul
						@copy "%FILE_DADOSTEMP%" "%PATH_FILE_DADOSTEMP_ORIGEM%" >nul
						@del "%FILE_DADOSTEMP%"
						REM @echo !PATH_IMPORTACAO!\ORIGEM\CLIENTE.XLS|clip
						REM @echo !PATH_IMPORTACAO!\ORIGEM\FORNECEDOR.XLS|clip
						REM @echo !PATH_IMPORTACAO!\ORIGEM\TRANSPORTADORA.XLS|clip
						REM @echo !PATH_IMPORTACAO!\ORIGEM\PRODUTO.XLS|clip
						@echo !VAR_FILE!|clip
					)
					@popd
					rem Base_Limpa
					rem --------------------------------------------------
					@echo %VAR_TAB%- Extraindo base limpa
					@pushd "!PATH_IMPORTACAO!\DESTINO"
					if not exist "!FILE_LIMPA!" call:getLimpa S
					if exist "!FILE_LIMPA!" (
						@copy "!FILE_LIMPA!" "!PATH_DESTINO_LIMPA!" /y >nul
						@"!PATH_DESTINO_LIMPA!" -s >nul
						if exist "!PATH_DESTINO_LIMPA!" del "!PATH_DESTINO_LIMPA!" >nul
						if exist "!FILE_DADOSTEMP!" del "!FILE_DADOSTEMP!" >nul
						if exist "!FILE_BCK_TEMP!" del "!FILE_BCK_TEMP!" >nul
						@copy "!PATH_DESTINO_LIMPA_BCK!" "!FILE_BCK_TEMP!" /y >nul
						@"%FILE_EXE_GBAK%" -c -user %FB3_USER% -pass %FB3_SENHA% "!FILE_BCK_TEMP!" "!FILE_DADOSTEMP!"
						@copy "!FILE_DADOSTEMP!" "!PATH_DESTINO_DADOS_FDB!" /y >nul
						if exist "!FILE_DADOSTEMP!" del "!FILE_DADOSTEMP!" >nul
						if exist "!FILE_BCK_TEMP!" del "!FILE_BCK_TEMP!" >nul
						if exist "!PATH_DESTINO_LIMPA_BCK!" del "!PATH_DESTINO_LIMPA_BCK!" >nul
					
					) else (
						set MSG_ERRO="!FILE_LIMPA!" não existe
						call:AvisaErroLimpa
					)
					@popd
					rem Futura.ini
					rem --------------------------------------------------
					@echo %VAR_TAB%- Configurando Futura.ini
					rem @call "!PATH_IMP_SCRIPTS!\1.1.SETUP_PATHS.BAT" "!PATH_IMPORTACAO!\ORIGEM" "!PATH_IMPORTACAO!\DESTINO" >nul
					@call "!PATH_IMP_SCRIPTS!\1.1.SETUP_PATHS.BAT" "!PATH_IMPORTACAO!\ORIGEM" "!PATH_IMPORTACAO!\DESTINO"
					rem Projeto_Importador
					rem --------------------------------------------------
					explorer "!PATH_FONTE_ATUAL!\Sistema"
					rem @echo %VAR_TAB%- Carregando Delphi Importador
					rem @"%FILE_DELPHI%" -pDelphi "!PATH_PROJETO_ATUAL!"
					rem Importacao.log
					rem --------------------------------------------------
					@echo %VAR_TAB%- Gravando logs
					call:ImportacaoLog
				) else ( set MSG_ERRO=%MSG_ERRO_NOEXIST% )
			) else (
				set MSG_ERRO=%MSG_ERRO_NOEXIST%
				goto:ERROR
			)
		) else ( 
			set MSG_ERRO=%MSG_ERRO_NOEXIST%
			goto:ERROR
		)
	) else (
		set MSG_ERRO=%MSG_ERRO_NOINPUT%
		goto:ERROR
	)
) else (
	set MSG_ERRO=%MSG_AMBIENTE%
	goto:ERROR
)
goto:exit

::FUNCTIONS
:getLimpa Anterior
if "%~1"=="S" (
	call:DataAmericana N N S
	set FILE_LIMPA_EXE=LIMPA!DataAmericana_return!.EXE
	set FILE_LIMPA=%PATH_LIMPA%\!FILE_LIMPA_EXE!
) else (
	call:DataAmericana N S
	set FILE_LIMPA_EXE=LIMPA!DataAmericana_return!.EXE
	set FILE_LIMPA=%PATH_LIMPA%\!FILE_LIMPA_EXE!
)
goto:eof

:AvisaErroLimpa
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul
goto:eof

:TimestampAtual
	if exist "!PATH_IMP_TS_ATUAL!" (
		for /f "tokens=* delims=" %%x in ("!PATH_IMP_TS_ATUAL!") do set "TimestampAtual_return=%%x"
		> "!PATH_IMP_TS_ATUAL!" (@echo !_IMP_DATA!_!VAR_AGORA!)
	) else ( 
		> "!PATH_IMP_TS_ATUAL!" (@echo !_IMP_DATA!_!VAR_AGORA!) 
	)
goto:eof

:GetExtension Path
set GetExtension_return=%~x1
goto:eof

:ImportacaoLog
@echo !_IMP_ALIAS! {>> %FILE_IMP_LOG%
@echo %VAR_TAB%INICIO:!_IMP_DATA!_!VAR_AGORA!>> %FILE_IMP_LOG%
@echo %VAR_TAB%ANTERIOR:!_IMP_ANTERIOR!>> %FILE_IMP_LOG%
@echo %VAR_TAB%ENGINE:!VAR_DB_EXTENSAO!>> %FILE_IMP_LOG%
@echo }>> %FILE_IMP_LOG%
goto:eof

:ImportacaoAnterior
	if exist "%FILE_IMP_ANTERIOR%" (
		for /f "tokens=* delims=" %%x in (%FILE_IMP_ANTERIOR%) do set "ImportacaoAnterior_return=%%x"
		> "%FILE_IMP_ANTERIOR%" (@echo %_IMP_ALIAS%)
	) else ( > "%FILE_IMP_ANTERIOR%" (@echo %_IMP_ALIAS%) )
goto:eof

:DataAmericana Pontos DiaMenosUm DiaMenosDois
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
if %DIA% EQU 08 set DIA=8
if %DIA% EQU 09 set DIA=9
if "%~2"=="S" set /a DIA=%DIA%-1
if "%~3"=="S" set /a DIA=%DIA%-2
( SETLOCAL
	set TAMANHO=...
	call:strLen DIA TAMANHO
)
( ENDLOCAL
	IF %TAMANHO% LSS 2 SET "DIA=0%DIA%"
)
if "%~1"=="S" (
	@set "DataAmericana_return=%ANO%.%MES%.%DIA%"
) else (
	@set "DataAmericana_return=%ANO%%MES%%DIA%"
)
goto:eof

:HoraAmericana Pontos
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
if "%~1"=="S" (
	@set "HoraAmericana_return=%HORA%.%MINUTO%.%SEGUNDO%"
) else (
	@set "HoraAmericana_return=%HORA%%MINUTO%%SEGUNDO%"
)
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

::SAIDAS
::------
:EXIT
echo.&echo %MSG_OK%&timeout 10>nul&goto:END
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end


:END