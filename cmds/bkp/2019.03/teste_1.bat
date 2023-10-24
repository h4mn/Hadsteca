@echo off
setlocal EnableDelayedExpansion
cls
:: - Pegar o numero do mes passado (09)
set _mes=...
call:getMes _mes
:: - Retornar os arquivos FDB com data de modificação do mes passado
for /f "delims=" %%F in ('dir /b /s *.fdb') do (
	set x=%%~tF
	set m=!x:~3,2!
	if /i !m! LEQ %_mes% (
		echo %%F & rem Retornar arquivo FDB pela data
		echo !x! & rem Retornar data do arquivo
		:: - Pegar Path do FDB para fazer o backup
		
	)
)
:: Proximas etapas

:: - Definir os Paths de Origem e Destino
:: - Pegar ID da Importacao
:: - Verificar se já existe o backup do mes anterior para os arquivos encontrados
:: - Fazer o Backup
:: - Certificar de que foi realizado o Backup
:: - Apagar a pasta Origem
:: - Objetivo (Ações para Economizar espaço no SSD) do Script Concluido
goto:fim

:getPathSetup Nivel Path
::         -- integer [in] - variavel que indica qual eh o nivel(pasta) do path serah retornado
::               -- string [out] - variavel que retorna o path no nivel escolhido

call:getPath 1
set WORKSPACE=%getPath_return%
call:getPath 2
set WS_BASES=%getPath_return%
call:getPath 3
set IMP_NOME=%getPath_return%
call:getPath 4
set PASTA=%getPath_return%
:getPath
SETLOCAL
for /f "tokens=1,2,3,4 delims=\" %%a in ("%~p0") do set "PASTA_ATUAL[1]=%%a"&set "PASTA_ATUAL[2]=%%b"&set "PASTA_ATUAL[3]=%%c"&set "PASTA_ATUAL[4]=%%d"
( ENDLOCAL
	IF %~1 == 1 SET getPath_return=%PASTA_ATUAL[1]%
	IF %~1 == 2 SET getPath_return=%PASTA_ATUAL[2]%
	IF %~1 == 3 SET getPath_return=%PASTA_ATUAL[3]%
	IF %~1 == 4 SET getPath_return=%PASTA_ATUAL[4]%
)
goto:eof

:getMes Mes
::   -- string [out] - variavel que retorna o mes anterior
:$created 20181023 :$changed 20181023 :$author Hadston Nunes
(	setlocal EnableDelayedExpansion
	set _mes=%date:~3,2%
	set _tamanho=...
	call:strLen _mesPassado _tamanho
)
set /a _mesPassado=%_mes%-1
(	endlocal	
	if %_tamanho% LSS 2 set %~1=0%_mesPassado% 
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

:fim
echo.&echo Fim . . .&pause>nul&goto:eof