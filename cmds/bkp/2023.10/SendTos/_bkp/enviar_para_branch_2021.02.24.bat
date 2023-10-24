::initializes
::----------------------------------------
echo off
@cls
setlocal ENABLEEXTENSIONS
setlocal ENABLEDELAYEDEXPANSION

::constants
@set "PC_AUTORIZADO=PROG19-VM"
@set "PATH_WORKSPACE=C:\_Fontes"
@set "TAB=    "

::variables
@chcp 1252 >nul
@set "MSG_TEXT="

::callback
set "_year="
call:getYear
set "_len="
call:strLen

::main
::----------------------------------------
:main
if %COMPUTERNAME% NEQ %PC_AUTORIZADO% call:setRaise 2 1

::presentation
call:setRaise 1 0
title %MSG_TEXT%
call:setRaise 3 0
@echo %MSG_TEXT%
@set "_de=%1"
@echo %TAB%"!_de!"
@echo.
call:setRaise 4 0
echo %MSG_TEXT%

::listBranchs
if not exist "%PATH_WORKSPACE%" call:setRaise 0 1
@set "_counter="
@set /a "_counter+=1"
@echo %TAB%!_counter!.trunk
for /f "tokens=*" %%p in ('dir /o:-d /b /a:d "%PATH_WORKSPACE%"') do (
    set "_branch=%%p"
    if "!_branch:~0,4!" EQU "!_year!" (
        @set /a "_counter+=1"
        @echo %TAB%!_counter!.%%p
    )
    set /a "_yearold=_year-1"
    if "!_branch:~0,4!" EQU "!_yearold!" (
        @set /a "_counter+=1"
        @echo %TAB%!_counter!.%%p
    )
)

::choice
@set /p "_pasta_escolha=>"||set "_pasta_escolha=nulo"
@set "_counter="
@set /a "_counter+=1"

set "BRANCH_ESCOLHIDA="
if "1" EQU "!_pasta_escolha!" (
    set "BRANCH_ESCOLHIDA=trunk"
)

rem for /f "tokens=*" %%p in ('dir /o:-d /t:c /b /a:d "%PATH_WORKSPACE%"') do (
rem     set "_brach_escolha=%%p"
rem     echo Index: "%%p"
rem     echo BranchEscolhida: "!_branch_escolha!"
rem 
rem ) 

	for /f "tokens=*" %%p in ('dir /o:-d /b /a:d "%PATH_WORKSPACE%"') do (
		set "BRANCH=%%p"
		if "!BRANCH:~0,4!" EQU "%_year%" (
			set /a "COUNTER+=1"
			if "!COUNTER!"=="!_PASTA_ESCOLHA!" (
				set "BRANCH_ESCOLHIDA=%%p"
				set _DE_SIZE=22
			)
		)
	)

echo Counter = PastaEscolhida
echo Counter: "!_counter! = !_pasta_escolha!"
echo BranchEscolhida: "!BRANCH_ESCOLHIDA!"&pause

::sendBranchChoiced

::copyClip

::functions
::----------------------------------------

::-getPath
:getPath
SETLOCAL
for /f "tokens=1,2,3,4,5,6,7,8 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"&set "PASTA_ATUAL[5]=%%d"&set "PASTA_ATUAL[6]=%%d"&set "PASTA_ATUAL[7]=%%d"&set "PASTA_ATUAL[8]=%%d"
( ENDLOCAL
	IF %~1 == 1 SET getPath_return=%PASTA_ATUAL[1]%
	IF %~1 == 2 SET getPath_return=%PASTA_ATUAL[2]%
	IF %~1 == 3 SET getPath_return=%PASTA_ATUAL[3]%
	IF %~1 == 4 SET getPath_return=%PASTA_ATUAL[4]%
    IF %~1 == 4 SET getPath_return=%PASTA_ATUAL[5]%
    IF %~1 == 4 SET getPath_return=%PASTA_ATUAL[6]%
    IF %~1 == 4 SET getPath_return=%PASTA_ATUAL[7]%
    IF %~1 == 4 SET getPath_return=%PASTA_ATUAL[8]%
)
goto:eof

::-getYear
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

::-strLen
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

::-setRaise
:setRaise Msg Raise
if "%~1"=="1" set MSG_TEXT=Utilitario Enviar Para:
if "%~1"=="2" set MSG_TEXT=Este script nao pode ser executado fora do ambiente
if "%~1"=="3" set MSG_TEXT=Arquivo a enviar:
if "%~1"=="4" set MSG_TEXT=Escolher Branch:
if "%~1"=="5" set MSG_TEXT=Nao foi possivel enviar arquivo
if "%~1"=="6" set MSG_TEXT=Caminho nao existe
if "%~1"=="7" set MSG_TEXT=Envia apenas a partir da Trunk
if "%~1"=="8" set MSG_TEXT=Path TRUNK faltando
if "%~2"=="0" (
    goto:eof
) else (
    goto:error
)

::finalizes
::----------------------------------------
:exit
goto:end

:error
@echo.&echo ERROR %ERRORLEVEL%: !MSG_TEXT!!&pause>nul&goto:END
goto:end

:end