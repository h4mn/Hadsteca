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
@set VAR_PC_AUTORIZADO=PROG19-VM
::@set VAR_PC_AUTORIZADO=DESKTOP-4A54RRC
@set PATH_WORKSPACE=C:\_Fontes
set "VAR_TAB=    "

set "_year="
call:getYear

rem Mensagens
set MSG_TITLE=Utilitario Enviar Para:
set MSG_AMBIENTE=Este script nao pode ser executado fora do ambiente
set MSG_INICIAL=Arquivo selecionado:
set MSG_INPUT=Escolher Branch:
set MGS_ERRORDEFAULT=Nao foi possivel enviar arquivo
set MSG_ERROCAMINHO=Caminho nao existe
set MSG_ERRO_SOTRUNK=Envia apenas a partir da Trunk


::MAIN
@if %COMPUTERNAME% EQU %VAR_PC_AUTORIZADO% (
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
	rem Lista Branchs
	for /f "tokens=*" %%p in ('dir /o:-d /t:c /b /a:d "%PATH_WORKSPACE%"') do (
		set "BRANCH=%%p"
		@if "!BRANCH:~0,4!" EQU "%_year%" (
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
	
	rem Lista Branchs
	for /f "tokens=*" %%p in ('dir /o:-d /t:c /b /a:d "%PATH_WORKSPACE%"') do (
		set "BRANCH=%%p"
		@if "!BRANCH:~0,4!" EQU "%_year%" (
			set /a "COUNTER+=1"
			if "!COUNTER!"=="!_PASTA_ESCOLHA!" (
				set "BRANCH_ESCOLHIDA=%%p"
				set _DE_SIZE=22
			)
		)
	)

	if "!_DE:~1,2!" EQU "C:" (
		set _PARA="%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~18!
		if "!_DE:~1,17!" NEQ "!PATH_WORKSPACE!\trunk\" (
			set MSG_ERRO=%MSG_ERRO_SOTRUNK%
			
			echo Debug: [_DE:~1]"!_DE:~0,1!"
			echo Debug: [_DE:~18]"%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~18!
			
			goto:error
		)
	) else (
		set _PARA=%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~17!
		if "!_DE:~0,17!" NEQ "!PATH_WORKSPACE!\trunk\" (
			set MSG_ERRO=%MSG_ERRO_SOTRUNK%

			echo Debug: [_DE:~0]"!_DE:~0,1!"
			echo Debug: [_DE:~17]"%PATH_WORKSPACE%\!BRANCH_ESCOLHIDA!\!_DE:~17!
			
			goto:error
		)
	)
	
	rem ENVIAR PARA
	rem ----------------------------
	if "!_DE:~0,2!" EQU "C:" (
		echo C eh o caracter #0
		@echo.
		@echo Copiando
		@echo %VAR_TAB%De  : !_DE!
		@echo %VAR_TAB%Para: !_PARA!
		@echo.
		@echo.
		@copy "!_DE!" "!_PARA!" /y >nul
	) else (
		if "!_DE:~1,2!" EQU "C:" (
			echo C eh o caracter #1
			@echo.
			@echo Copiando
			@echo %VAR_TAB%De  : !_DE!
			@echo %VAR_TAB%Para: !_PARA!
			@echo.
			@echo.
			@copy !_DE! !_PARA! /y >nul
		) else (
			@echo Problema com a posicao do caracter #1
		)
	)
	
	@echo !_PARA! |clip
	
) else (
	set MSG_ERRO=%MSG_AMBIENTE%
	goto:error
)
goto:exit

::FUNCTIONS

:getYear
for /f " tokens=2-4 delims=-./ " %%d in ( "%date%" ) do (
	if %%d gtr 31 (
		set "_year=%%d"
	) else (
		if %%e gtr 31 (
			set "_year=%%e"
		) else (
			if %%f gtr 31 (
				set "_year=%%f"
			)
		)
	)
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
:EXIT
@echo Arquivo copiado... &timeout /t 10
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END
rem pause