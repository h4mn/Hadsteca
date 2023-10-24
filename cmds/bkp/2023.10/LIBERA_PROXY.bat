@echo off
cls
SETLOCAL ENABLEEXTENSIONS 
SETLOCAL ENABLEDELAYEDEXPANSION 
@set PROXY_IP=192.168.1.1
@set PROXY_PORT=3128
@set /p PROXY_USER=User: || set PROXY_USER=NULL
rem <nul: set /p PROXY_PASSWORD=Password: || set PROXY_USER=NULL
rem <nul: set /p PROXY_PASSWORD=Password:
for /f "delims=" %%A in ('python -c "import getpass; print(getpass.getpass('Password: '));"') do @set PROXY_PASSWORD=%%A
ENDLOCAL

set HTTP_PROXY=http://%PROXY_USER%:%PROXY_PASSWORD%@%PROXY_IP%:%PROXY_PORT%
set HTTPS_PROXY=https://%PROXY_USER%:%PROXY_PASSWORD%@%PROXY_IP%:%PROXY_PORT%

:exit
@echo Proxy liberado...&pause>nul&goto:end
goto:end

:END