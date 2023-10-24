:: Este batch tem por objetivo gerar os arquivos de configura��o da importa��o.
:: A importa��o precisa de dois arquivos de configura��o. O primeiro � o arquivo de configura��o da base de origem, origem.ini. O segundo � o arquivo de configura��o da base de destino, futura.ini. Os dois arquivos ser�o salvos na mesma pasta deste batch.
:: [dados] A primeira linha � padr�o para os dois arquivos, � uma chave descrevendo o bloco de configura��es.
:: DADOS_ALIAS= A segunda linha, para o arquivo de configura��o de destino, � o alias que ser� mostrado na tela de login; 
:: IMPORTACAO_ID= A segunda linha, para o arquivo de configura��o de origem, � o id da importa��o.

:: Ambiente
@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
chcp 1252 >nul

:: Variaveis
set "VAR_TAB=  "

:: Configura a janela
title Gera arquivos de configura��o da importa��o

:: Variaveis da configura��o de ORIGEM
:: ===================================
set FILE_ORIGEM=origem.ini
set INI_SENHA=sbofutura
:: Configura��es para o firebird
set INI_DRIVERID_FB=Firebird
set INI_IP_FB=serverimport/3050
set INI_ALIAS_FB=%~dp0origem.fdb
set INI_USUARIO_FB=sysdba
:: Configura��es para o postgres
set INI_IP_PG=serverimport
set INI_DRIVERID_PG=PG
set INI_USUARIO_PG=postgres


:: Variaveis da configura��o de DESTINO
:: ===================================
set FILE_DESTINO=futura.ini
set INI_DADOS_IP=serverimport/3050
set INI_DADOS_PATH=%~dp0destino.fdb
set INI_FIREBIRD_OPCAO=sbofutura

:: Variaveis de configura��o de Mensagens
:: ======================================
set "MSG_ERRO_FALTA_ORIGEMFDB=Verifique se o arquivo ORIGEM.FDM est� na mesma pasta deste batch."
set "MSG_ERRO_FALTA_DESTINOFDB=Verifique se o arquivo DESTINO.FDM est� na mesma pasta deste batch."
set "MSG_ERRO_FALTAM_OS_DOIS_ARQUIVOS=Verifique se os arquivos ORIGEM.FDM e DESTINO.FDM est�o na mesma pasta deste batch."

:: Verificar se no diret�rio atual existe o arquivo Origem.fdb e Destino.fdm
set ERRO=0
if not exist "%INI_ALIAS_FB%" if not exist "%INI_DADOS_PATH%" set ERRO=3
if not exist "%INI_DADOS_PATH%" set ERRO=2
if not exist "%INI_ALIAS_FB%" set ERRO=1

if %ERRO%==3 goto :SaidaComErroMsgOrigemDestino3
if %ERRO%==2 goto :SaidaComErroMsgDestino2
if %ERRO%==1 goto :SaidaComErroMsgOrigem1

:: Perguntar ao usu�rio o ID da importa��o
echo.
set /p PROMPT_ID="Informe o ID da importa��o: "
set INI_IMPORTACAO_ID=%PROMPT_ID%
set INI_DADOS_ALIAS=%PROMPT_ID%
:: Sempre criar o banco de dados, no postgres, com este nome (dbi_14958)
set INI_ALIAS_PG=dbi_%PROMPT_ID%

:: Perguntar ao usu�rio o engine do banco de dados
echo.
:EscolherEngine
set /p PROMPT_ENGINE="Informe o engine do banco de dados [0]firebird, [1]postgre: "
:: Se o usu�rio digitar um valor diferente de 0 ou 1, voltar para :EscolherEngine
if %PROMPT_ENGINE%==0 goto :EngineEscolhido
if %PROMPT_ENGINE%==1 goto :EngineEscolhido
goto :EscolherEngine

:EngineEscolhido

echo ================================================
echo.
echo Gerando arquivos de configura��o da importa��o...

:: Construir c�digo abaixo para o origem.ini
if exist "%INI_IMPORTACAO%" (
    @del "%INI_IMPORTACAO%"
) else (
    > "%FILE_ORIGEM%" (
        echo [dados]
        echo IMPORTACAO_ID=%INI_IMPORTACAO_ID%

        :: Conforme o engine escolhido, o driverID e o alias ser�o diferentes
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

:: Construir c�digo abaixo para o futura.ini
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

:: Feedback para o usu�rio
timeout /t 1 /nobreak > nul
echo.
echo %VAR_TAB%- Arquivo: %FILE_ORIGEM% criado
echo %VAR_TAB%- Arquivo: %FILE_DESTINO% criado
echo.
echo ================================================
pause
goto :Saida

:SaidaComErroMsgOrigem1
:: Feedback para o usu�rio do erro MSG_ERRO_FALTA_ORIGEMFDB
echo.
echo ERRO: O arquivo n�o existe nesta pasta
echo %VAR_TAB%- %MSG_ERRO_FALTA_ORIGEMFDB%
echo %VAR_TAB%- Este batch deve ser executado na mesma pasta dos arquivos ORIGEM.FDB e DESTINO.FDB
echo.
echo ================================================
pause
goto :Saida

:SaidaComErroMsgDestino2
:: Feedback para o usu�rio do erro MSG_ERRO_FALTA_DESTINOFDB
echo.
echo ERRO: O arquivo n�o existe nesta pasta
echo %VAR_TAB%- %MSG_ERRO_FALTA_DESTINOFDB%
echo %VAR_TAB%- Este batch deve ser executado na mesma pasta dos arquivos ORIGEM.FDB e DESTINO.FDB
echo.
echo ================================================
pause
goto :Saida

:SaidaComErroMsgOrigemDestino3
:: Feedback para o usu�rio do erro MSG_ERRO_FALTAM_OS_DOIS_ARQUIVOS
echo.
echo ERRO: Os arquivos n�o existem nesta pasta
echo %VAR_TAB%- %MSG_ERRO_FALTAM_OS_DOIS_ARQUIVOS%
echo %VAR_TAB%- Este batch deve ser executado na mesma pasta dos arquivos ORIGEM.FDB e DESTINO.FDB
echo.
echo ================================================
pause
goto :Saida

:: Fim do batch
:Saida
exit