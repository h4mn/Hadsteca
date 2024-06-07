# -*- coding: utf-8 -*-
#
# script: atualiza_acbr.py
# descrição: Verifica etapas personalizadas aqui da Futura Sistemas para a atualização do ACBr
# Versão: 1.0
# Data: 2024-06-03
# Autor: Hadston Nunes
# 
# Etapas feitas manualmente:
# 1. Utilizar o utilitário ApagarAcbr.bat
# 2. Apagar conteúdo da c:\componentes\acbr
# 3. Fazer checkout na c:\componentes\acbr a partir de http://fontes.futurasistemas.com.br/svn/AcbrTrunk2
# 4. Verificar se a lib Vcl está na propriedade Unit scope names do projeto dclfrce.bpl;
# 5. Buildar frce e dclfrce;
# 6. Instalar dclfrce;
# 7. Instalar Acbr (com o parâmetro Não utilizar Capicom desmarcado - pois vamos utilizar o Capicom);
# 8. Instalar Fortes;
# 9. Limpar DCUs;
# 10. Verificar se o path para FortesReport está duplicado no Library path e no Browsing path, tanto para o 32 quanto para o 64;
# 11. a) Ao buildar vai dar um erro do Jedi - tem um comentário na unit que vai dar o erro explicando pra readicionar um caminho que o instalador do acbr sempre tira;
# 11. b) Limpar DCUs novamente e reiniciar o Delphi;
# 12. Buildar a Biblioteca;
# 13. Acbr atualizado e biblioteca buildada;
#
# Erros comuns ao atualizar o ACBr:
# - Ao abrir as opções do dclfrce, o Delphi pode reescrever as palavras chaves do arquivo dpr: contains, requires e end de forma incorreta;
# - Biblioteca e Projeto FuturaServer devem estar na mesma versão (32 ou 64 bits);
# - Manter apenas um path para um componente, pois pode estar com paths repetidos lá no library/browse;

import os
import sys
import shutil
import subprocess

def apagar_acbr():
    print('Apagando arquivos do ACBr...')
    os.system('C:\\componentes\\acbr\\ApagarAcbr.bat')
    print('Arquivos do ACBr apagados com sucesso!')

def apagar_conteudo_acbr():
    print('Apagando conteúdo da pasta c:\\componentes\\acbr...')
    shutil.rmtree('C:\\componentes\\acbr')
    print('Conteúdo da pasta c:\\componentes\\acbr apagado com sucesso!')

def checkout_acbr():
    print('Fazendo checkout do ACBr...')
    os.system('svn checkout http://fontes.futurasistemas.com.br/svn/AcbrTrunk2 C:\\componentes\\acbr')
    print('Checkout do ACBr feito com sucesso!')

def buildar_frce():
    print('Buildando frce...')
    os.system('C:\\componentes\\acbr\\frce\\BuildFrce.bat')
    print('frce buildado com sucesso!')

def buildar_dclfrce():
    print('Buildando dclfrce...')
    os.system('C:\\componentes\\acbr\\dclfrce\\BuildDclFrce.bat')
    print('dclfrce buildado com sucesso!')

def instalar_dclfrce():
    print('Instalando dclfrce...')
    os.system('C:\\componentes\\acbr\\dclfrce\\InstallDclFrce.bat')
    print('dclfrce instalado com sucesso!')

def instalar_acbr():
    print('Instalando ACBr...')
    os.system('C:\\componentes\\acbr\\InstallAcbr.bat')
    print('ACBr instalado com sucesso!')

def instalar_fortes():
    print('Instalando Fortes...')
    os.system('C:\\componentes\\acbr\\InstallFortes.bat')
    print('Fortes instalado com sucesso!')

def limpar_dcus():
    print('Limpando DCUs...')
    os.system('C:\\componentes\\acbr\\LimparDcus.bat')
    print('DCUs limpas com sucesso!')

def buildar_biblioteca():
    print('Buildando biblioteca...')
    os.system('C:\\componentes\\acbr\\BuildBiblioteca.bat')
    print('Biblioteca buildada com sucesso!')  

def main():
    apagar_acbr()
    apagar_conteudo_acbr()
    checkout_acbr()
    buildar_frce()
    buildar_dclfrce()
    instalar_dclfrce()
    instalar_acbr()
    instalar_fortes()
    limpar_dcus()
    buildar_biblioteca()