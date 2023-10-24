::CABECALHO
::----------------------------------------------------------------------
::Doc by Hasd
::---------
rem Teste de compilação via ms-dos

::Display Uses
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

::Encoding
::---------
rem Certifique-se de que esteja vendo a palavra em pt-BR (Compilacao: Compilação)
@chcp 1252 >nul

::VARIAVEIS
::----------------------------------------------------------------------

::Compilador
::---------
rem Tentativa de pegar o path do compilador do delphi automaticamente
set "BOL_AUTOPATH=1"
if "!BOL_AUTOPATH!" == "1" (
    for /f "tokens=2 delims=\" %%a in ('reg query "HKU"') do (
        set "STR_QUERY=HKEY_USERS\%%a\Software\Embarcadero\BDS\18.0"
        for /f "tokens=1,3,4,5 delims= " %%b in ('reg query "!STR_QUERY!" /v "RootDir" 2^>nul')  do (
            set "STR_KEYVALUE=%%b"
             set "STR_PATH_DELPHI=%%c %%d %%e"
            if "!STR_KEYVALUE!" == "RootDir" (
                set "PATH_DELPHI_COMP=!STR_PATH_DELPHI!bin\dcc32.exe"
            )
        )
    )
) else (
    rem Path do compilador do delphi que pode ser setado manualmente
    set "PATH_DELPHI_COMP=C:\Program Files (x86)\Embarcadero\Studio\18.0\bin\dcc32.exe"
)

rem echo "!PATH_DELPHI_COMP!"
if exist "!PATH_DELPHI_COMP!" echo Compilador encontrado.

::Projeto
::---------
set "PATH_DELPHI_PROJETO=C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Sistemas\FuturaServer"
if exist "!PATH_DELPHI_PROJETO!" echo Projeto encontrado.

::MAIN
::----------------------------------------------------------------------
    title "Build FuturaServer.dpr"
    pushd "!PATH_DELPHI_PROJETO!"
    @"!PATH_DELPHI_COMP!" -B "!PATH_DELPHI_PROJETO!\FuturaServer.dpr"
    popd

::END
::----------------------------------------------------------------------
pause