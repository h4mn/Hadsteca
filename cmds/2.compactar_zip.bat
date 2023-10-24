@echo off
@cls
set FILE_7ZIP_VM=%ProgramFiles%\7-Zip\7z.exe
set FILE_7ZIP_PO=E:\Hadston\Downloads\7z1805-extra\7za.exe
set FILE_GBAK_FI=C:\Program Files\Firebird\Firebird_3_0\gbak.exe
set FILE_FDB=DADOS.FDB
set FILE_BCK=DADOS.BCK
set FILE_ZIP=DADOS.ZIP
@echo COMPACTANDO BCK ...
@"%FILE_GBAK_FI%" -b -v -user sysdba -pass masterkey "%FILE_FDB%" "%FILE_BCK%"
@echo. 
pause
@echo COMPACTANDO ZIP ...
@"%FILE_7ZIP_VM%" a -tzip "%FILE_ZIP%" "%FILE_BCK%" -r- -y
@echo. 

@echo DELETANDO FDB ...
REM @del %FILE_FDB%
@echo. 
@echo ====================
@echo BASE COMPACTADA !
pause