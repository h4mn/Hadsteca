REM ENVIRONMENT ====================================================================
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
rem -----------------------------------------------------------
rem SETS
rem -----------------------------------------------------------
set FILE_BASELIMPA=...
set PATH_WORKSPACE=Z:\WORKSPACE
set PATH_DST_BA=%PATH_WORKSPACE%\BASES
set PATH_FONTES=C:\_Fontes\Utilitarios\Importacao\_DelphiXe10
set PATH_ORG_BN=I:\BasesNovas
set PATH_DST_BL=R:\17 - BaseLimpa
call:DataBaseLimpa
rem --------
rem --------
@echo INICIANDO SETUP DA "%IMP_NOME%"
@echo =========================================================
@"%PATH_DST_BA%\%IMP_NOME%\DESTINO\%FILE_DST_BL%"
@del %FILE_DST_BL%
@chdir ..\..
@echo.

@echo =========================================================
echo.&ECHO.PAUSE PERSONALIZADO E SAI!&PAUSE>NUL&GOTO:EOF


explorer "%PATH_FONTES%\%IMP_NOME%\UTILITARIOS\Sistema\"
@"%ProgramFiles(X86)%\Notepad++\Notepad++.exe" "%PATH_FONTES%\%IMP_NOME%\_EXE\Futura.ini"

EXIT:
@rem RESTAURAR - Descompacta o Backup BCK - PROXIMO DESAFIO
@rem @%ProgramFiles%"\Firebird\Firebird_3_0\gbak.exe" -c -v -user sysdba -pass masterkey Limpa.bck DADOS.FDB
@rem del Limpa.bck
@rem COMANDO PARA RETORNAR O NOME DA PASTA ATUAL
@rem for %i in (.) do echo %~nxi

@rem Referencias
@rem https://en.wikibooks.org/wiki/Windows_Batch_Scripting
goto:eof

:DataBaseLimpa
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
set /a DIA=%DIA%-1
( SETLOCAL
	set TAMANHO=...
	call:strLen DIA TAMANHO
)
( ENDLOCAL
	IF %TAMANHO% LSS 2 SET "DIA=0%DIA%"
)
set "FILE_BASELIMPA=LIMPA%ANO%%MES%%DIA%.EXE"
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

:EXIT