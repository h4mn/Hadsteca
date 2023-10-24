:: Este batch tem por objetivo gerar os arquivos de configuração da importação.
:: A importação precisa de dois arquivos de configuração. O primeiro é o arquivo de configuração da base de origem, origem.ini. O segundo é o arquivo de configuração da base de destino, futura.ini. Os dois arquivos serão salvos na mesma pasta deste batch.
:: [dados] A primeira linha é padrão para os dois arquivos, é uma chave descrevendo o bloco de configurações.
:: DADOS_ALIAS= A segunda linha, para o arquivo de configuração de destino, é o alias que será mostrado na tela de login; 
:: IMPORTACAO_ID= A segunda linha, para o arquivo de configuração de origem, é o id da importação.

:: Ambiente
@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul

:: Variaveis
set "VAR_TAB=  "

:: Configura a janela
title Gera arquivos de configuração da importação

:: Variaveis da configuração de ORIGEM
:: ===================================
set FILE_ORIGEM=origem.ini
set INI_SENHA=sbofutura
:: Configurações para o firebird
set INI_DRIVERID_FB=Firebird
set INI_IP_FB=serverimport/3050
set INI_ALIAS_FB=%~dp0origem.fdb
set INI_USUARIO_FB=sysdba
:: Configurações para o postgres
set INI_IP_PG=serverimport
set INI_DRIVERID_PG=PG
set INI_USUARIO_PG=postgres


:: Variaveis da configuração de DESTINO
:: ===================================
set FILE_DESTINO=futura.ini
set INI_DADOS_IP=serverimport/3050
set INI_DADOS_PATH=%~dp0destino.fdb
set INI_FIREBIRD_OPCAO=sbofutura

:: Variaveis de configuração de Mensagens
:: ======================================
set "MSG_ERRO_FALTA_ORIGEMFDB=Verifique se o arquivo ORIGEM.FDM está na mesma pasta deste batch."
set "MSG_ERRO_FALTA_DESTINOFDB=Verifique se o arquivo DESTINO.FDM está na mesma pasta deste batch."
set "MSG_ERRO_FALTAM_OS_DOIS_ARQUIVOS=Verifique se os arquivos ORIGEM.FDM e DESTINO.FDM estão na mesma pasta deste batch."

:: Verificar se no diretório atual existe o arquivo Origem.fdb e Destino.fdm
set ERRO=0
if not exist "%INI_ALIAS_FB%" if not exist "%INI_DADOS_PATH%" set ERRO=3
if not exist "%INI_DADOS_PATH%" set ERRO=2
if not exist "%INI_ALIAS_FB%" set ERRO=1

if %ERRO%==3 goto :SaidaComErroMsgOrigemDestino3
if %ERRO%==2 goto :SaidaComErroMsgDestino2
if %ERRO%==1 goto :SaidaComErroMsgOrigem1

:: Perguntar ao usuário o ID da importação
echo.
set /p PROMPT_ID="Informe o ID da importação: "
set INI_IMPORTACAO_ID=%PROMPT_ID%
set INI_DADOS_ALIAS=%PROMPT_ID%
:: Sempre criar o banco de dados, no postgres, com este nome (dbi_14958)
set INI_ALIAS_PG=dbi_%PROMPT_ID%

:: Perguntar ao usuário o engine do banco de dados
echo.
:EscolherEngine
set /p PROMPT_ENGINE="Informe o engine do banco de dados [0]firebird, [1]postgre: "
:: Se o usuário digitar um valor diferente de 0 ou 1, voltar para :EscolherEngine
if %PROMPT_ENGINE%==0 goto :EngineEscolhido
if %PROMPT_ENGINE%==1 goto :EngineEscolhido
goto :EscolherEngine

:EngineEscolhido

echo ================================================
echo.
echo Gerando arquivos de configuração da importação...

:: Construir código abaixo para o origem.ini
if exist "%INI_IMPORTACAO%" (
    @del "%INI_IMPORTACAO%"
) else (
    > "%FILE_ORIGEM%" (
        echo [dados]
        echo IMPORTACAO_ID=%INI_IMPORTACAO_ID%

        :: Conforme o engine escolhido, o driverID e o alias serão diferentes
        if %PROMPT_ENGINE%==0 (
            echo DRIVERID=%INI_DRIVERID_FB%
            echo IP=%INI_IP_FB%
            echo ALIAS=%INI_ALIAS_FB%
            echo USUARIO=%INI_USUARIO_FB%
        ) else if %PROMPT_ENGINE%==1 (
            echo DRIVERID=%INI_DRIVERID_PG%
            echo IP=%INI_IP_PG%
            echo ALIAS=%INI_ALIAS_PG%
            echo USUARIO=%INI_USUARIO_PG%
        )
        echo SENHA=%INI_SENHA%
    )    
)

:: Construir código abaixo para o futura.ini
if exist "%INI_FUTURA%" (
    @del "%INI_FUTURA%"
) else (
    > "%FILE_DESTINO%" (
        echo [BASE_01]
        echo DADOS_ALIAS=%INI_DADOS_ALIAS%
        echo DADOS_IP=%INI_DADOS_IP%
        echo DADOS_PATH=%INI_DADOS_PATH%
        echo FIREBIRD_OPCAO=%INI_FIREBIRD_OPCAO%
    )    
)

:: Feedback para o usuário
timeout /t 1 /nobreak > nul
echo.
echo %VAR_TAB%- Arquivo: %FILE_ORIGEM% criado
echo %VAR_TAB%- Arquivo: %FILE_DESTINO% criado
echo.
echo ================================================
pause
goto :Saida

:SaidaComErroMsgOrigem1
:: Feedback para o usuário do erro MSG_ERRO_FALTA_ORIGEMFDB
echo.
echo ERRO: O arquivo não existe nesta pasta
echo %VAR_TAB%- %MSG_ERRO_FALTA_ORIGEMFDB%
echo %VAR_TAB%- Este batch deve ser executado na mesma pasta dos arquivos ORIGEM.FDB e DESTINO.FDB
echo.
echo ================================================
pause
goto :Saida

:SaidaComErroMsgDestino2
:: Feedback para o usuário do erro MSG_ERRO_FALTA_DESTINOFDB
echo.
echo ERRO: O arquivo não existe nesta pasta
echo %VAR_TAB%- %MSG_ERRO_FALTA_DESTINOFDB%
echo %VAR_TAB%- Este batch deve ser executado na mesma pasta dos arquivos ORIGEM.FDB e DESTINO.FDB
echo.
echo ================================================
pause
goto :Saida

:SaidaComErroMsgOrigemDestino3
:: Feedback para o usuário do erro MSG_ERRO_FALTAM_OS_DOIS_ARQUIVOS
echo.
echo ERRO: Os arquivos não existem nesta pasta
echo %VAR_TAB%- %MSG_ERRO_FALTAM_OS_DOIS_ARQUIVOS%
echo %VAR_TAB%- Este batch deve ser executado na mesma pasta dos arquivos ORIGEM.FDB e DESTINO.FDB
echo.
echo ================================================
pause
goto :Saida

:: Fim do batch
:Saida
exit