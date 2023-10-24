@echo off
@cls
@echo ===============================================================================
rem CHAMADA A FUNCTION
set HOJE=ASDF
call:DataAmericano
@echo %HOJE%
pause
@goto:eof

:DataAmericano
set DIA=%date:~0,2%
set /a DIA=%DIA%-1
set MES=%date:~3,2%
set ANO=%date:~6,4%
set HOJE=%ANO%.%MES%.%DIA%
@goto:eof

pause
EXIT: