REM ENVIRONMENT ====================================================================
@echo OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
rem -----------------------------------------------------------
rem SETS
rem -----------------------------------------------------------
set TITLE=BACKUP-RESTORE
set PATH_7ZIP=%ProgramFiles%\7-Zip\7z.exe
set PATH_7ZIP_PORTABLE=E:\BACKUP\Downloads\7z1805-extra\7za.exe
set PATH_GBAK=%ProgramFiles%\Firebird\Firebird_3_0\gbak.exe
set FILE_FDB=DADOS.FDB
set FILE_BCK=DADOS.BCK
set FILE_ZIP=DADOS.ZIP
set FIREBIRD_USER=sysdba
set FIREBIRD_SENHA=masterkey
rem -----------------------------------------------------------
rem --------
rem --------
:INICIO
@cls
@echo %TITLE%
@echo =========================================================
if %COMPUTERNAME% EQU PROGRAMACAO19 (
	rem FAZ BACKUP-RESTORE
	@echo INICIANDO BACKUP-RESTORE
	goto:proc_BackupRestore
) else (
	rem AVISA QUE NÃO ESTÁ NO PROGRAMACAO19
	@echo FIREBIRD 3 NAO INSTALADO NA MAQUINA %COMPUTERNAME%
	goto:ERROR
)
@echo.
pause
goto:EOF

:proc_BackupRestore
if EXIST %FILE_BCK% del %FILE_BCK%
@echo. 
rem COMPACTAR
@echo COMPACTAR %FILE_FDB% ...
@echo. 
pause
@"%PATH_GBAK%" -b -v -user sysdba -pass masterkey "%FILE_FDB%" "%FILE_BCK%"
if %ERRORLEVEL% NEQ 0 goto:ERROR
@echo.
@echo %FILE_BCK% COMPACTADA!
@del %FILE_FDB%
rem RESTAURAR
@echo RESTAURAR %FILE_BCK% ...
@echo. 
pause
@"%PATH_GBAK%" -c -v -user %FIREBIRD_USER% -pass %FIREBIRD_SENHA% "%FILE_BCK%" "%FILE_FDB%"
@echo %FILE_FDB% RESTAURADA!
rem ZIPAR
@echo ZIPAR %FILE_ZIP% ...
@echo. 
pause
@"%PATH_7ZIP_PORTABLE%" a -tzip "%FILE_ZIP%" "%FILE_BCK%" -r- -y
@echo.
@echo %FILE_ZIP% ZIPADO!
@echo.
pause
goto:EOF

:ERROR
@echo.
@echo EXCEPTION ERRORLEVEL %ERRORLEVEL% QUIT!
pause
:EXIT