::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul
::VARIAVEIS
::---------
set "VAR_TAB=    "
set "_year="
call:getYear
::==================================================
@set "_ANO_ANTERIOR=2022"
@set PATH_WORKSPACE=C:\_tmp\_fontes
::==================================================
rem Mensagens
set MSG_TITLE=Enviar Para Branch
set MSG_AMBIENTE=Este script nao pode ser executado fora do ambiente
set MSG_INICIAL=Arquivo selecionado:
set MSG_INPUT=Escolher Branch:
set MSG_DFM_FILE=DFM:
set MSG_DFM=Enviar DFM correspondente? [S/N]
set MGS_ERRORDEFAULT=Nao foi possivel enviar arquivo
set MSG_ERROCAMINHO=Caminho nao existe
set MSG_ERRO_SOTRUNK=Envia apenas a partir da Trunk

::MAIN
::---------
	title %MSG_TITLE%
	set _DE=%1

	@echo %MSG_INICIAL%
	@echo %VAR_TAB%"!_DE!"
	@echo.
	@echo %MSG_INPUT%
	rem LISTAR OPÇÕES
	rem ----------------------------
	rem Lista Trunk
	set "COUNTER="
	if exist "%PATH_WORKSPACE%\trunk" (
		set /a "COUNTER+=1"
		@echo %VAR_TAB%!COUNTER!.trunk
	)

	rem Lista Branchs Ano Atual
	for /f "tokens=*" %%p in ('dir /o:-n /t:c /b /a:d "%PATH_WORKSPACE%"') do ( REM Por ordem alfabetica decrescente
		set "BRANCH=%%p"
		@if "!BRANCH:~0,4!" EQU "%_year%" (
			set /a "COUNTER+=1"
			@echo %VAR_TAB%!COUNTER!.%%p
		)
	)
	rem Lista Branchs Ano Anterior
	for /f "tokens=*" %%p in ('dir /o:-n /t:c /b /a:d "%PATH_WORKSPACE%"') do ( REM Por ordem alfabetica decrescente
		set "BRANCH=%%p"
		@if "!BRANCH:~0,4!" EQU "%_ANO_ANTERIOR%" (
			set /a "COUNTER+=1"
			@echo %VAR_TAB%!COUNTER!.%%p
		)
	)

	rem RECEBER ESCOLHA
	rem ----------------------------
	set /p _PASTA_ESCOLHA=">"||set _PASTA_ESCOLHA=NULO
	rem COMPARAR ESCOLHA
	rem ----------------------------
	rem Lista Trunk
	set "COUNTER="
	if exist "%PATH_WORKSPACE%\trunk" (
		set /a "COUNTER+=1"
		if "!COUNTER!"=="!_PASTA_ESCOLHA!" (
			set "BRANCH_ESCOLHIDA=trunk"
			set _DE_SIZE=17
		)
	)

	rem CONCATENAR BRANCH ESCOLHIDA
	rem ----------------------------
	rem Ano Atual
	for /f "tokens=*" %%p in ('dir /o:-n /t:c /b /a:d "%PATH_WORKSPACE%"') do (
		set "BRANCH=%%p"
		@if "!BRANCH:~0,4!" EQU "%_year%" (
			set /a "COUNTER+=1"
			if "!COUNTER!"=="!_PASTA_ESCOLHA!" (
				set "BRANCH_ESCOLHIDA=%%p"
				set _DE_SIZE=22
			)
		)
	)
	rem Ano Anterior
	for /f "tokens=*" %%p in ('dir /o:-n /t:c /b /a:d "%PATH_WORKSPACE%"') do (
		set "BRANCH=%%p"
		@if "!BRANCH:~0,4!" EQU "%_ANO_ANTERIOR%" (
			set /a "COUNTER+=1"
			if "!COUNTER!"=="!_PASTA_ESCOLHA!" (
				set "BRANCH_ESCOLHIDA=%%p"
				set _DE_SIZE=22
			)
		)
	)
	rem Compara path COM aspas (""C:\_tmp\_fontes\trunk\RepTmp\..."")
	if "!_DE:~1,2!" EQU "C:" (
		
		rem ""C:\_tmp\_fontes\trunk\R"" - O caracter "R" é o 23, se iniciar no aspas
		set _PARA="%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~23!

		if "!_DE:~1,22!" NEQ "!PATH_WORKSPACE!\trunk\" (
			rem Se entrar aqui o path está errado
			
			set MSG_ERRO=%MSG_ERRO_SOTRUNK%
			
			echo Debug - Primeiro caracter: [_DE:~1]"!_DE:~0,1!"
			echo Debug - Resultado: [_DE:~23]"%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~23!
			
			goto:error
		)		
	)
	rem Compara path SEM aspas ("C:\_tmp\_fontes\trunk\RepTmp\...")
	if "!_DE:~0,2!" EQU "C:" (

		rem "C:\_tmp\_fontes\trunk\R" - O caracter "R" é o 22, se NÃO iniciar no aspas
		set _PARA="%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~22!
		if "!_DE:~1,21!" NEQ "!PATH_WORKSPACE!\trunk\" (
			rem Se entrar aqui o path está errado

			set MSG_ERRO=%MSG_ERRO_SOTRUNK%
			
			echo Debug - Primeiro caracter: [_DE:~1]"!_DE:~0,1!"
			echo Debug  -Resultado: [_DE:~22]"%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~22!
			
			goto:error
		)
	)

	rem ==================================================
	rem ENVIAR DFM
	rem ----------------------------
	if "!_DE:~0,2!" EQU "C:" (
		rem Adiciona Aspas ao final da sentença
		set _DFM_DE=!_DE:~0,-4!dfm"
		set _DFM_PARA=!_PARA:~0,-4!dfm"
	) else (
		rem NÃO adiciona Aspas ao final da sentença
		set _DFM_DE=!_DE:~1,-4!dfm
		set _DFM_PARA=!_PARA:~1,-4!dfm
	)
	set "_ESCOLHA_DFM_TRUE="
	@echo.
	@echo !MSG_DFM_FILE! !_DFM_DE!
	@echo.
	@echo %MSG_DFM%
	set /p _ESCOLHA_DFM=">"||set _ESCOLHA_DFM=NULO
	if "!_ESCOLHA_DFM!" EQU "s" set _ESCOLHA_DFM_TRUE=1
	if "!_ESCOLHA_DFM!" EQU "S" set _ESCOLHA_DFM_TRUE=1
	if "!_ESCOLHA_DFM_TRUE!" EQU "1" (
		rem @echo %VAR_TAB%Opcao escolhida: S
		@echo %VAR_TAB%"!_DFM_DE!"
	)

	rem ==================================================
	rem ENVIAR PARA
	rem ----------------------------
	if "!_DE:~0,2!" EQU "C:" (
		echo C eh o caracter #0
		@echo.
		@echo Copiando
		@echo %VAR_TAB%De  : !_DE!
		@echo %VAR_TAB%Para: !_PARA!
		if "!_ESCOLHA_DFM_TRUE!" EQU "1" (
			@echo %VAR_TAB%De: !_DFM_DE!
			@echo %VAR_TAB%Para: !_DFM_PARA!
		)
		@echo.
		@echo.
		@copy "!_DE!" "!_PARA!" /y >nul
		if "!_ESCOLHA_DFM_TRUE!" EQU "1" (
			@copy "!_DFM_DE!" "!_DFM_PARA!" /y >nul
		)
	) else (
		if "!_DE:~1,2!" EQU "C:" (
			echo C eh o caracter #1
			@echo.
			@echo Copiando
			@echo %VAR_TAB%De  : !_DE!
			@echo %VAR_TAB%Para: !_PARA!
			if "!_ESCOLHA_DFM_TRUE!" EQU "1" (
				@echo %VAR_TAB%De: !_DFM_DE!
				@echo %VAR_TAB%Para: !_DFM_PARA!
			)
			@echo.
			@echo.
			@copy !_DE! !_PARA! /y >nul
			if "!_ESCOLHA_DFM_TRUE!" EQU "1" (
				@copy "!_DFM_DE!" "!_DFM_PARA!" /y >nul
			)
		) else (
			@echo Problema com a posicao do caracter #1
		)
	)
	
	@echo !_PARA! |clip
goto:exit

::FUNCTIONS
:: ----------------------------
:getYear
for /f " tokens=3 delims=-./ " %%a in ( "%date%" ) do (
		set "_year=%%a"
)
goto:eof
:: ----------------------------
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
:EXIT
@echo Arquivo copiado... &timeout /t 10
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END
rem pause