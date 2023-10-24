@REM Autor: Hadston Nunes
@REM Atualiza Componentes Raize
@REM v0.1 - 2023.07.03

@REM Script para atualizar os componentes Raize em um ambiente Windows.

@REM Objetivo: 
@REM O objetivo deste script é copiar os arquivos *.pas de uma pasta de origem para uma pasta de destino, realizando um backup dos arquivos existentes no destino antes da substituição. Além disso, o script cria um arquivo ZIP com a data atual contendo os arquivos de backup. Por fim, o script executa o comando de build dos componentes atualizados.

@REM Funcionamento:
@REM 1. O script verifica se está sendo executado com privilégios administrativos. Caso contrário, exibe uma mensagem de erro e encerra a execução.
@REM 2. É verificado se o executável do programa de compactação (7-Zip) está configurado corretamente. Caso contrário, exibe uma mensagem de erro e encerra a execução.
@REM 3. É criada uma pasta de backup, caso não exista, para armazenar os arquivos que serão substituídos.
@REM 4. O script entra na pasta de destino.
@REM 5. Para cada arquivo *.pas na pasta de origem, o script realiza as seguintes ações:
@REM    a. Cria um backup do arquivo na pasta de backup, mantendo o nome original.
@REM    b. Copia o arquivo para a pasta de destino, substituindo o arquivo existente.
@REM 6. O script compacta os arquivos de backup em um arquivo ZIP com o nome "Backup_YYYY.MM.DD.zip", onde "YYYY" representa o ano, "MM" o mês e "DD" o dia.
@REM 7. O script exibe uma mensagem de conclusão da compactação do backup.
@REM 8. O script executa o comando de build dos componentes atualizados, utilizando o script "!Build_RC6.cmd" na pasta de destino.
@REM 9. O script retorna à pasta de origem.
@REM 10. O script exibe uma mensagem de conclusão informando que os componentes foram atualizados com sucesso.

@REM Configurações:
@REM - Pasta de Origem: Caminho para a pasta que contém os arquivos *.pas a serem copiados.
@REM - Pasta de Backup: Caminho para a pasta onde os arquivos *.pas substituídos serão armazenados como backup.
@REM - Pasta de Destino: Caminho para a pasta onde os arquivos *.pas serão copiados.
@REM - Executável ZIP: Caminho para o executável do programa de compactação (7-Zip) para criar o arquivo ZIP de backup.

@REM Observações:
@REM - O script requer privilégios administrativos para realizar as operações de cópia e criação de pasta.
@REM - É importante configurar corretamente os caminhos das pastas e do executável do 7-Zip antes de executar o script.
@REM - É recomendado testar o script em um ambiente de teste antes de executá-lo em um ambiente de produção.

@echo off
setlocal enabledelayedexpansion
@chcp 1252 >nul

REM --- Configuração ---
set "pasta_origem=C:\_tmp\_fontes\trunk\Biblioteca\Custamização\Raize"
set "pasta_destino=C:\Componentes\RC6\Source"
set "pasta_backup=C:\Componentes\RC6\Source\Backup"
set "executavel_zip=C:\Program Files\7-Zip\7z.exe"

REM --- Verificação de privilégios administrativos ---
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
  echo Este script requer privilégios administrativos. Por favor, execute-o como administrador.
  pause
  exit /b
)

REM --- Verificação do executavel zip
if not exist "%executavel_zip%" (
  echo Este script requer um programa de compactação. Por favor, adicione seu executavel zip na configuração.
  pause
  exit /b
)

REM --- Criação da pasta de backup ---
if not exist "%pasta_backup%" mkdir "%pasta_backup%"

REM --- Nome do arquivo de backup com data atual ---
set "data=%date:~6,4%.%date:~3,2%.%date:~0,2%"
set "arquivo_backup=%pasta_backup%\Backup_%data%.zip"

REM --- Entrar na pasta de destino ---
pushd "%pasta_destino%"

REM --- Cópia dos arquivos com backup ---
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

REM --- compactação dos arquivos de backup ---
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
