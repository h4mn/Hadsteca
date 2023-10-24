REM ENVIRONMENT ====================================================================
@echo OFF
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
REM --------------------------------------------------------------------------------
set EXE_FLAMEROBIN=C:\Program Files (x86)\FlameRobin\flamerobin.exe
REM --------------------------------------------------------------------------------

@Rem Reinicia o FlameRobin
tskill flamerobin
@"%EXE_FLAMEROBIN%"
pause

@Rem Reinicia o Firebird
net stop “Firebird Server - DefaultInstance”
net start “Firebird Server - DefaultInstance”
pause

@echo. 
@echo ====================
@echo Firebird e FlameRobin reiniciados !

pause
:EXIT