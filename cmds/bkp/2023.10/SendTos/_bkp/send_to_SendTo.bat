echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul

::Ambiente
set "PATH_ROOT=Z:\DEV"
set "PATH_SENDTO=%AppData%\Microsoft\Windows\SendTo"

::Linkfile in SendTo
set "LNK_FILE_01=%PATH_SENDTO%\Branch Anterior.lnk"

::Files Copy to SendTo
set "FILE_01=%PATH_ROOT%\enviarpara_BranchAnterior.bat"

::Main
echo.
echo if  not exist "%LNK_FILE_01%" (
echo copy "%PATH_ROOT%\%PATH_FUTURAINI%" "%~1" /y nul&echo %VAR_TAB%%~1 copiado
if  not exist "%LNK_FILE_01%" (
    echo @copy "%PATH_ROOT%\%PATH_FUTURAINI%" "%~1" /y >nul&echo %VAR_TAB%%~1 copiado
) 

::Exit
:EXIT
echo.&echo Em desenvolvimento...%pause>nul

:END