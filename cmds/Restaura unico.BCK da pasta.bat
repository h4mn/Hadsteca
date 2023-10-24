@echo off
setlocal enabledelayedexpansion
@chcp 1252 >nul

REM --- Configuração ---
set "pasta_atual=%~dp0"
set "gbak_utilitario=%ProgramFiles%\Firebird\Firebird_4_0\gbak.exe"
set "usuario=sysdba"
set "senha=sbofutura"
set "servidor_fdb=localhost/3050"
rem "servidor_fdb3=localhost/3051"
rem "servidor_fdb4=localhost/3050"

REM --- Verificação do número de arquivos BCK na pasta ---
set "bck_count=0"
for %%F in ("%pasta_atual%*.bck") do (
  set /a "bck_count+=1"
)
if %bck_count% neq 1 (
  echo Falha ao executar o script. É necessário haver apenas um arquivo BCK na pasta.
  pause
  exit /b
)

REM --- Descompactação do arquivo BCK para FDB ---
for %%F in ("%pasta_atual%*.bck") do (
  set "bck_arquivo=%%~nF"
  set "fdb_arquivo=%servidor_fdb%:%%~dpnF.fdb"

  if not exist "!fdb_arquivo!" (
    echo Descompactando: !bck_arquivo!.bck -> !fdb_arquivo!

    REM --- Restauração do arquivo BCK com Firebird 4 ---
    "%gbak_utilitario%" -C -v -user %usuario% -password %senha% -FIX_FSS_M win1252 -FIX_FSS_D win1252 "%%F" "!fdb_arquivo!"

  ) else (
    echo Já existe um arquivo FDB com o mesmo nome do arquivo BCK encontrado: !bck_arquivo!.bck
    echo Não é necessário descompactar novamente.
    pause
    exit /b
  )
)

echo.
echo Restauração concluída com sucesso.
pause
