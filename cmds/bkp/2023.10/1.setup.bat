REM ENVIRONMENT ====================================================================
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
rem -----------------------------------------------------------
rem PATHS RAIZ
rem -----------------------------------------------------------
set LETRA_WORKSPACE=Z:
set PATH_DST_BA=%LETRA_WORKSPACE%\BASES
set PATH_BASES=%LETRA_WORKSPACE%\BASES
set PATH_DEV=%LETRA_WORKSPACE%\DEV
set PATH_FONTES=C:\_Fontes\Utilitarios\Importacao\_DelphiXe10
set PATH_ORG_BN=I:\BasesNovas
set PATH_DST_BL=R:\17 - BaseLimpa
rem -----------------------------------------------------------
rem FILES
rem -----------------------------------------------------------
set FILE_BASELIMPA=...
call:DataBaseLimpa
set FILE_DST_BL=%FILE_BASELIMPA%
set FILE_ORG_BN=DADOS.ZIP
rem -----------------------------------------------------------
rem IMPORTACAO
rem -----------------------------------------------------------
rem --------
rem --------
set IMP_NOME=8160 - JOCILII B FERREIRA
set IMP_DATA=2019.02.18
rem --------
set IMP_ANTERIOR=8032 - GBX COMERCIO EXTERIOR LTDA - ME
rem --------
rem --------
@echo.
@echo SETUP IMPORTACAO
@echo.
@echo "%IMP_NOME%"
@echo ===========================================================
@echo.
@echo AMBIENTE
@echo.
CHCP > CODEPAGE.TMP
SET /p SET_CP= < CODEPAGE.TMP
DEL CODEPAGE.TMP
@echo CHARCODEPAGE : %SET_CP%
@echo -----------------------------------------------------------
@echo.
@echo ORIGEM
@echo.
@echo PATH_ORG_BN  : %PATH_ORG_BN%
@echo IMP_NOME     : %IMP_NOME%
@echo IMP_DATA     : %IMP_DATA%
@echo FILE_ORG_BN  : %FILE_ORG_BN%
@echo -----------------------------------------------------------
@echo.
@echo DESTINO
@echo.
@echo PATH_DST_BA  : %PATH_DST_BA%
@echo -----------------------------------------------------------
@echo.
@echo LIMPA
@echo.
@echo PATH_DST_BL  : %PATH_DST_BL%
@echo FILE_DST_BL  : %FILE_DST_BL%
@echo -----------------------------------------------------------
@echo.
@echo CODIGO FONTE
@echo.
@echo PATH_FONTES  : %PATH_FONTES%
@echo IMP_ANTERIOR : %IMP_ANTERIOR%
@echo -----------------------------------------------------------
@echo.
rem -----------------------------------------------------------
rem echo "%PATH_DST_BL%\%FILE_ORG_BN%" "%PATH_DST_BA%\%IMP_NOME%\DESTINO" /y
@pause
REM @goto EXIT
rem -----------------------------------------------------------
@echo.
@rem CRIA AS PASTAS
@echo CRIANDO PASTAS...
@mkdir "%PATH_DST_BA%\%IMP_NOME%"
@mkdir "%PATH_FONTES%\%IMP_NOME%"
@mkdir "%PATH_FONTES%\%IMP_NOME%\UTILITARIOS"
@echo.
@rem COPIA OS FONTES
@echo COPIANDO FONTES...
@xcopy "%PATH_DEV%\MODELO" "%PATH_FONTES%\%IMP_NOME%" /e /y
@xcopy "%PATH_FONTES%\%IMP_ANTERIOR%\UTILITARIOS" "%PATH_FONTES%\%IMP_NOME%\UTILITARIOS" /e /y
REM CRIAR ROTINA PARA INSERIR TIPO DE DATABASE. EX.: PD, DB, FB, FF, XL, SS, MS, NS
@echo.
@rem COPIA OS MODELOS
@echo COPIANDO MODELOS...
@xcopy "%PATH_DEV%\MODELO" "%PATH_DST_BA%\%IMP_NOME%" /e /y
@del "%PATH_DST_BA%\%IMP_NOME%\_EXE\Futura.ini"
@del "%PATH_DST_BA%\%IMP_NOME%\_EXE\GDS32.DLL"
@echo.
@rem COPIA BASENOVA
@echo COPIANDO BASENOVA...
@xcopy "%PATH_ORG_BN%\%IMP_NOME%\*.*" "%PATH_DST_BA%\%IMP_NOME%\DOCUMENTOS" /y
@xcopy "%PATH_ORG_BN%\%IMP_NOME%\PRINTS" "%PATH_DST_BA%\%IMP_NOME%\PRINTS" /s /y
@xcopy "%PATH_ORG_BN%\%IMP_NOME%\%IMP_DATA%\DADOS.ZIP" "%PATH_DST_BA%\%IMP_NOME%\ORIGEM" /y
@echo.
@rem EXTRAI BASENOVA
@echo EXTRAINDO BASENOVA...
@chdir "%PATH_DST_BA%\%IMP_NOME%\ORIGEM"
@"%ProgramFiles%\7-Zip\7z.exe" e %FILE_ORG_BN% -y -sdel
@chdir ..\..
@echo.
@rem EXTRAI BASELIMPA
@echo EXTRAINDO BASELIMPA...
@xcopy "%PATH_DST_BL%\%FILE_DST_BL%" "%PATH_DST_BA%\%IMP_NOME%\DESTINO" /y
@chdir "%PATH_DST_BA%\%IMP_NOME%\DESTINO"
@"%PATH_DST_BA%\%IMP_NOME%\DESTINO\%FILE_DST_BL%" -s
@del %FILE_DST_BL%
@chdir ..\..

:: Novas implementações
::-------------------------------------------------------------
@set PATH_IMPORTACAO_SCRIPTS=%PATH_DST_BA%\%IMP_NOME%\SCRIPTS

@echo.&echo Restaurar Base Limpa &pause>nul
call "%PATH_IMPORTACAO_SCRIPTS%\1.1.RESTAURAR_LIMPA_DESTINO.BAT"

@echo.&echo Criar Nova Base de Origem &pause>nul
call "%PATH_IMPORTACAO_SCRIPTS%\1.1.NOVA_ORIGEM.BAT"

@echo.&echo Configurar Futura.ini &pause>nul
call "%PATH_IMPORTACAO_SCRIPTS%\1.1.SETUP_PATHS.BAT"
::-------------------------------------------------------------

@echo.
@echo =========================================================
@echo SETUP DA "%IMP_NOME%" CONCLUIDO!
@echo.
@echo.&echo Iniciar Ambiente de Desenvolvimento &pause>nul
@cls
@echo.
@echo =========================================================
@echo SETUP DA "%IMP_NOME%" CONCLUIDO!
@echo.
@echo.&echo Importação %IMP_NOME% em desenvolvimento...
@echo =========================================================
::Carrega Projeto no Delphi
"C:\Program Files (x86)\Embarcadero\Studio\18.0\bin\bds.exe" -pDelphi "%PATH_FONTES%\%IMP_NOME%\UTILITARIOS\Sistema\Project.groupproj"
@echo.&echo Importação %IMP_NOME% finalizada! &pause>nul&goto:END
REM explorer "%PATH_FONTES%\%IMP_NOME%\UTILITARIOS\Sistema\"
REM @"%ProgramFiles(X86)%\Notepad++\Notepad++.exe" "%PATH_FONTES%\%IMP_NOME%\_EXE\Futura.ini"

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
if %DIA% EQU 08 set DIA=8
if %DIA% EQU 09 set DIA=9
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