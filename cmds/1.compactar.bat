REM ENVIRONMENT ====================================================================
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
set FILE_DADOSFDB=LAYOUT.FDB
REM --------------------------------------------------------------------------------
set FILE_BASEBCK=LAYOUT.bck
REM --------------------------------------------------------------------------------
set USER=sysdba
set SENHA=masterkey
set EXE_GBAK=%ProgramFiles%\Firebird\Firebird_3_0\gbak.exe

@Rem COMPACTA O FDB
@echo.
@"%EXE_GBAK%" -b -v -user %USER% -pass %SENHA% "%FILE_DADOSFDB%" "%FILE_BASEBCK%"

@echo. 
@echo ====================
@echo BASE COMPACTADA !

pause
:EXIT