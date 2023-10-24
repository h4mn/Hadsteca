REM ENVIRONMENT ====================================================================
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
REM --------------------------------------------------------------------------------
set FILE_BASEBCK=LAYOUT.BCK
REM --------------------------------------------------------------------------------
set FILE_DADOSFDB=LAYOUT.FDB
set USER=sysdba
set SENHA=masterkey
set EXE_GBAK=%ProgramFiles%\Firebird\Firebird_3_0\gbak.exe

@Rem DESCOMPACTA O BCK
@echo.
REM COM FIX DE UNICODE_FSS
@"%EXE_GBAK%" -c -v -user %USER% -pass %SENHA% "%FILE_BASEBCK%" "%FILE_DADOSFDB%" -FIX_FSS_M win1252 -FIX_FSS_D win1252
REM SEM FIX
REM @"%EXE_GBAK%" -c -v -user %USER% -pass %SENHA% "%FILE_BASEBCK%" "%FILE_DADOSFDB%"
REM @del "%FILE_BASEBCK%"

@echo. 
@echo ====================
@echo BASE DESCOMPACTADA !

pause
:EXIT