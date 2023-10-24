::CABECALHO
::----------------------------------------------------------------------
::Doc by ChatGPT
::---------
rem Este � um script de atualiza��o de componentes feito para ser executado no prompt de comando do Windows. O script tem como objetivo atualizar a trunk (c�digo-fonte principal) de uma aplica��o mantida no Subversion (SVN), e em seguida copiar arquivos espec�ficos de duas bibliotecas (FuturaComponents e Raize) para um diret�rio de destino.

rem O script come�a definindo algumas vari�veis que ser�o usadas ao longo do c�digo, incluindo caminhos de origem e destino para as bibliotecas, nomes de arquivos espec�ficos a serem copiados, e informa��es sobre o t�tulo, vers�o e mensagens do script.
rem Em seguida, o script exibe uma mensagem de t�tulo no prompt de comando e come�a a execu��o das tarefas. Primeiro, ele executa o comando "svn update" para atualizar a trunk. Em seguida, ele usa o comando "xcopy" para copiar os arquivos das bibliotecas FuturaComponents e Raize para o diret�rio de destino.
rem Finalmente, o script exibe uma mensagem de "Componentes atualizados" e espera que o usu�rio pressione qualquer tecla antes de encerrar a execu��o.

::Display Uses
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

::Encoding
rem Certifique-se de que esteja vendo a palavra em pt-BR (Compilacao: Compila��o)
@chcp 1252 >nul

::FuturaComponents
::---------
set FUTCOMP_PATH_ORIGEM=C:\_tmp\_fontes\trunk\Biblioteca\FuturaComponents\1.0\src
set FUTCOMP_PATH_DESTINO=C:\Componentes\FuturaComponents\1.0\src

rem set FUTCOMP_FILE_0=NAO_ATUALIZAR.pas
set FUTCOMP_FILE_1=uTGroupBoxDinamico.pas
set FUTCOMP_FILE_2=uTMultiSelect.pas
set FUTCOMP_FILE_3=uTRegisterFuturaComponents.pas

::Raize
::---------
set RAIZE_PATH_ORIGEM=C:\_tmp\_fontes\trunk\Biblioteca\Custamiza��o\Raize
set RAIZE_PATH_DESTINO=C:\Componentes\RC6\Source

rem set RAIZE_FILE_0=NAO_ATUALIZAR.pas
set RAIZE_FILE_1=RzButton.pas
set RAIZE_FILE_2=RzDBCmbo.pas
set RAIZE_FILE_3=RzTabs.pas

::Trunk
::---------
set TRUNK_PATH=C:\_tmp\_fontes\trunk
set TRUNK_SVN=C:\Program Files\TortoiseSVN\bin\svn.exe

::Mensagens
::---------
set MSG_TITLE=Atualizador de Componentes
set MSG_OK=Componentes atualizados.
set MSG_VERSAO=0.1

::MAIN
::----------------------------------------------------------------------
    ::Prompt
    ::---------
    title !MSG_TITLE! v!MSG_VERSAO!
    @echo !MSG_TITLE! v!MSG_VERSAO!
    
    @echo.
    ::Atualizar Trunk
    ::---------
    rem Assumindo que o SVN esteja configurado corretamente e funcionando
    @echo.
    @echo Atualizando a trunk...
    @"!TRUNK_SVN!" update "!TRUNK_PATH!"

    @echo.
    ::Copiar arquivos
    ::---------
    @echo.
    @echo Copiando FuturaComponents...
    @xcopy "!FUTCOMP_PATH_ORIGEM!\!FUTCOMP_FILE_1!" "!FUTCOMP_PATH_DESTINO!\!FUTCOMP_FILE_1!" /e /y >nul
    @xcopy "!FUTCOMP_PATH_ORIGEM!\!FUTCOMP_FILE_2!" "!FUTCOMP_PATH_DESTINO!\!FUTCOMP_FILE_2!" /e /y >nul
    @xcopy "!FUTCOMP_PATH_ORIGEM!\!FUTCOMP_FILE_3!" "!FUTCOMP_PATH_DESTINO!\!FUTCOMP_FILE_3!" /e /y >nul
    @echo Copiando Raize...
    @xcopy "!RAIZE_PATH_ORIGEM!\!RAIZE_FILE_1!" "!RAIZE_PATH_DESTINO!\!RAIZE_FILE_1!" /e /y >nul
    @xcopy "!RAIZE_PATH_ORIGEM!\!RAIZE_FILE_2!" "!RAIZE_PATH_DESTINO!\!RAIZE_FILE_2!" /e /y >nul
    @xcopy "!RAIZE_PATH_ORIGEM!\!RAIZE_FILE_3!" "!RAIZE_PATH_DESTINO!\!RAIZE_FILE_3!" /e /y >nul

    ::Conclus�o
    ::---------
    pause
    @echo !MSG_OK!