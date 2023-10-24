REM ENVIRONMENT ====================================================================
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
set UNIDADE=%~d0
set PATH_SCRIPT=%~0
REM FUNCTIONS ======================================================================
call:getPath 1
set WS_BASES=%getPath_return%
call:getPath 2
set IMP_NOME=%getPath_return%
call:getPath 3
set PASTA=%getPath_return%
call:DataAmericano
set IMP_DATA=%HOJE%
REM END FUNCTIONS ==================================================================
set PATH_DESTINO=I:\BasesImportadas
set PATH_ORIGEM=%UNIDADE%\%WS_BASES%
set WS_IMPORTACAO=%PATH_DESTINO%\%IMP_NOME%\%IMP_DATA%
set DADOS_FDB=%PATH_ORIGEM%\%IMP_NOME%\DESTINO\DADOS.FDB
set DADOS_ZIP=%PATH_ORIGEM%\%IMP_NOME%\DESTINO\DADOS.ZIP
@echo PUBLICANDO "%IMP_NOME%"
@echo ================================================================================
@echo PATH_SCRIPT   : %PATH_SCRIPT%
@echo PATH_ORIGEM   : %PATH_ORIGEM%
@echo IMP_NOME      : %IMP_NOME%
@echo IMP_DATA      : %IMP_DATA%
@echo PATH_DESTINO  : %PATH_DESTINO%
@echo WS_IMPORTACAO : %WS_IMPORTACAO%
@echo.
rem -----------------------------------------------------------
@pause
REM @goto RODAPE
rem -----------------------------------------------------------
@echo.
@echo ================================================================================
rem CRIA AS PASTAS 
@echo CRIANDO PASTA EM "%PATH_DESTINO%\%IMP_NOME%\%IMP_DATA%" ...
@mkdir "%PATH_DESTINO%\%IMP_NOME%"
@mkdir "%PATH_DESTINO%\%IMP_NOME%\%IMP_DATA%"
@echo.
@echo ================================================================================
rem COMPACTA PARA DADOS.ZIP
if NOT EXIST %DADOS_ZIP% (
	@echo COMPACTANDO PARA DADOS.ZIP ...
	"%ProgramFiles%\7-Zip\7z.exe" a -tzip "%DADOS_ZIP%" "%DADOS_FDB%" -r- -y
)
@echo.
@echo ================================================================================
rem COPIA A BASE
@echo COPIANDO BASE PARA "%PATH_DESTINO%\%IMP_NOME%\%IMP_DATA%\DADOS.ZIP" ...
@xcopy "%DADOS_ZIP%" "%PATH_DESTINO%\%IMP_NOME%\%IMP_DATA%\DADOS.ZIP"
@xcopy "%PATH_ORIGEM%\%IMP_NOME%\*.*" "%PATH_DESTINO%\%IMP_NOME%\"
@del "%DADOS_ZIP%"
@echo.
@echo ================================================================================
rem COPIA SCRIPTS PARA MODELO
REM @echo COPIANDO SCRIPTS PARA MODELO ...
REM @xcopy *.BAT "%PATH_ORIGEM%\9999 - MODELO\DESTINO\"
:RODAPE
@echo ================================================================================
@echo BASE PUBLICADA EM "%PATH_DESTINO%\%IMP_NOME%\%IMP_DATA%"
@echo.
set IMPORTACAO_WS=%PATH_DESTINO:~1%
@echo [IMPORTACAO]%IMPORTACAO_WS%\%IMP_NOME%\%IMP_DATA%
@echo [IMPORTACAO]%IMPORTACAO_WS%\%IMP_NOME%\%IMP_DATA% | clip
@echo.
pause
goto:eof

:DataAmericano
set DIA=%date:~0,2%
set MES=%date:~3,2%
set ANO=%date:~6,4%
set HOJE=%ANO%.%MES%.%DIA%
goto:eof

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

:EXIT