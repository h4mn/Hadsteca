@REM Autor: Hadston Nunes
@REM Atualiza Componentes Raize
@REM v0.1 - 2023.07.03

@REM Script para atualizar os componentes Raize em um ambiente Windows.

@REM Objetivo: 
@REM O objetivo deste script � copiar os arquivos *.pas de uma pasta de origem para uma pasta de destino, realizando um backup dos arquivos existentes no destino antes da substitui��o. Al�m disso, o script cria um arquivo ZIP com a data atual contendo os arquivos de backup. Por fim, o script executa o comando de build dos componentes atualizados.

@REM Funcionamento:
@REM 1. O script verifica se est� sendo executado com privil�gios administrativos. Caso contr�rio, exibe uma mensagem de erro e encerra a execu��o.
@REM 2. � verificado se o execut�vel do programa de compacta��o (7-Zip) est� configurado corretamente. Caso contr�rio, exibe uma mensagem de erro e encerra a execu��o.
@REM 3. � criada uma pasta de backup, caso n�o exista, para armazenar os arquivos que ser�o substitu�dos.
@REM 4. O script entra na pasta de destino.
@REM 5. Para cada arquivo *.pas na pasta de origem, o script realiza as seguintes a��es:
@REM    a. Cria um backup do arquivo na pasta de backup, mantendo o nome original.
@REM    b. Copia o arquivo para a pasta de destino, substituindo o arquivo existente.
@REM 6. O script compacta os arquivos de backup em um arquivo ZIP com o nome "Backup_YYYY.MM.DD.zip", onde "YYYY" representa o ano, "MM" o m�s e "DD" o dia.
@REM 7. O script exibe uma mensagem de conclus�o da compacta��o do backup.
@REM 8. O script executa o comando de build dos componentes atualizados, utilizando o script "!Build_RC6.cmd" na pasta de destino.
@REM 9. O script retorna � pasta de origem.
@REM 10. O script exibe uma mensagem de conclus�o informando que os componentes foram atualizados com sucesso.

@REM Configura��es:
@REM - Pasta de Origem: Caminho para a pasta que cont�m os arquivos *.pas a serem copiados.
@REM - Pasta de Backup: Caminho para a pasta onde os arquivos *.pas substitu�dos ser�o armazenados como backup.
@REM - Pasta de Destino: Caminho para a pasta onde os arquivos *.pas ser�o copiados.
@REM - Execut�vel ZIP: Caminho para o execut�vel do programa de compacta��o (7-Zip) para criar o arquivo ZIP de backup.

@REM Observa��es:
@REM - O script requer privil�gios administrativos para realizar as opera��es de c�pia e cria��o de pasta.
@REM - � importante configurar corretamente os caminhos das pastas e do execut�vel do 7-Zip antes de executar o script.
@REM - � recomendado testar o script em um ambiente de teste antes de execut�-lo em um ambiente de produ��o.

@echo off
setlocal enabledelayedexpansion
@chcp 1252 >nul

REM --- Configura��o ---
set "pasta_origem=C:\_tmp\_fontes\trunk\Biblioteca\Custamiza��o\Raize"
set "pasta_destino=C:\Componentes\RC6\Source"
set "pasta_backup=C:\Componentes\RC6\Source\Backup"
set "executavel_zip=C:\Program Files\7-Zip\7z.exe"

REM --- Verifica��o de privil�gios administrativos ---
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
  echo Este script requer privil�gios administrativos. Por favor, execute-o como administrador.
  pause
  exit /b
)

REM --- Verifica��o do executavel zip
if not exist "%executavel_zip%" (
  echo Este script requer um programa de compacta��o. Por favor, adicione seu executavel zip na configura��o.
  pause
  exit /b
)

REM --- Cria��o da pasta de backup ---
if not exist "%pasta_backup%" mkdir "%pasta_backup%"

REM --- Nome do arquivo de backup com data atual ---
set "data=%date:~6,4%.%date:~3,2%.%date:~0,2%"
set "arquivo_backup=%pasta_backup%\Backup_%data%.zip"

REM --- Entrar na pasta de destino ---
pushd "%pasta_destino%"

REM --- C�pia dos arquivos com backup ---
for %%F in ("%pasta_origem%\*.pas") do (
  set "arquivo=%%~nxF"
  copy /y "%%F" "%pasta_backup%\!arquivo!" >nul
  if %errorLevel% equ 0 (
    copy /y "%%F" "!arquivo!" >nul 2>&1
    echo - Arquivo !arquivo! copiado com sucesso e backup criado.
  ) else (
    echo - Falha ao copiar o arquivo !arquivo!.
    pause
    exit /b
  )
)

REM --- compacta��o dos arquivos de backup ---
if not exist "%arquivo_backup%" (
  "%executavel_zip%" a -tzip "%arquivo_backup%" "%pasta_backup%\*.pas" >nul
  if %errorLevel% equ 0 (
    echo Backup compactado com sucesso.
    del "%pasta_backup%\*.pas" >nul
  ) else (
    echo Falha ao compactar o backup.
    pause
    exit /b
  )
)

REM --- Build dos componentes ---
echo Compoentes antigos backupeados, continuar para a build...
pause
"%pasta_destino%\!Build_RC6.cmd"

REM --- Sair da pasta de destino ---
popd

echo.
echo Componentes atualizados.
pause
