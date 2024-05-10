#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Modulo: scrapping.py
Autor: Hadston Nunes
Data: 2024.05.09
Versão: 1.0

Descrição:
Este script faz a raspagem de dados de uma página web.

Movitvação:
Este script foi desenvolvido para atender a necessidade de 
coletar informações dos aplicativos do consumidor publicados
na Google Play Store.

Uso:
    1. Baixar a página com os dados de todos aplicativos;
        - Pra pegar os dados, abrir a DevTool (F12);
        - Copiar o node HTML cru da página que contenha a lista de Aplicativos;
    2. Salvar a página no mesmo diretório deste script;
    3. Ao Executar o script, os dados serão salvos 
    num novo arquivo *.csv.

    python scrapping.py 1.html
"""
import sys
import os
import re
import csv

# Como instalar bs4: pip install beautifulsoup4
from bs4 import BeautifulSoup

# file_entrada = "1.html"
file_entrada = "pretty.html"
file_saida = "apps.csv"

# Capturar o nome do arquivo
if len(sys.argv) == 2:
    arquivo = sys.argv[1]
else:
    arquivo = file_entrada

# Concatenar nome do arquivo com o path deste script
arquivo = f"{os.path.dirname(os.path.realpath(__file__))}/{arquivo}"
file_saida = f"{os.path.dirname(os.path.realpath(__file__))}/{file_saida}"

# Abrir o arquivo
with open(arquivo, "r", encoding="utf-8") as f:
    html = f.read()

# Parsear o HTML
soup = BeautifulSoup(html, "html.parser")

def depura_linha(i, j):
    print(f"{i}.{j}: {dados[(i, j)]}")

# Inicializar o arquivo CSV
# with open(file_saida, "w", encoding="utf-8") as f:
with open(file_saida, "w", newline='') as f:
    writer = csv.writer(f)
    writer.writerow(["NOME", "ID", "ACTIVE", "APP_STATUS", "UPDATE_STATUS", "UPDATE"])

    # criar dicionario com os dados
    dados = {}

    # Iterar com enumerate sobre as linhas da tabela <div class="particle-table-row" role="row">
    for i, linha in enumerate(soup.find_all("div", class_="particle-table-row")):

        # Iterar sobre as celulas da linha
        for j, celula in enumerate(linha.find_all("ess-cell")):

            # 0 - App Name (app-cell)
            if celula.get("essfield") == 'app-cell':
                # Pegar o texto da celula
                texto = celula.text.replace("\n", "").strip()
                # adicionar a uma lista o app-name e o app-id
                # RM Calçados                                 br.com.futura.ecommerce.ecommercermcalcados
                texto = texto.split()
                #['RM', 'Calçados', 'br.com.futura.ecommerce.ecommercermcalcados']
                # Concatenar todos os itens da lista se não for o ultimo
                app_name = ""
                for k, item in enumerate(texto):
                    if k == len(texto) - 1:
                        app_id = item
                    else:
                        app_name += item + " "
                
                # Adicionar a uma lista
                dados[(i, j)] = [app_name, app_id]
                depura_linha(i, j)

            # 1 - Active Users (active-users-cell)
            if celula.get("essfield") == 'active-users-cell':
                # Pegar o texto da span com a classe "main-text _ngcontent-gzh-60"
                active_users = celula.find("span", class_="main-text _ngcontent-gzh-60").text
                dados[(i, j)] = active_users.replace("\n", "").strip()
                depura_linha(i, j)

            # 2 - App Status (app-status-cell)
            if celula.get("essfield") == 'app-status-cell':
                # Pegar o texto da span com a classe "main-text _ngcontent-gzh-60"
                app_status = celula.find("span", class_="main-text _ngcontent-gzh-60").text
                dados[(i, j)] = app_status.replace("\n", "").strip()
                depura_linha(i, j)

            # 3 - Update Status (update-status-cell)
            if celula.get("essfield") == 'update-status-cell':
                # Pegar o texto da span com a classe "main-text _ngcontent-gzh-60"
                update_status = celula.find("span", class_="main-text _ngcontent-gzh-60").text
                if update_status.replace("\n", "").strip() == "":
                    update_status = "null"
                else:
                    update_status = update_status.replace("\n", "").strip()
                dados[(i, j)] = update_status
                depura_linha(i, j)

            # 4 - Last Update (last-updated-cell)
            if celula.get("essfield") == 'last-updated-cell':
                # Pegar o texto da celula text-field
                last_update = celula.find("text-field",).text
                if last_update.replace("\n", "").strip() == "":
                    last_update = "null"
                else:
                    last_update = last_update.replace("\n", "").strip()
                dados[(i, j)] = last_update
                depura_linha(i, j)

    for i in range(len(dados) // 5):
        writer.writerow([
            dados[(i, 0)][0],
            dados[(i, 0)][1],
            dados[(i, 1)],
            dados[(i, 2)],
            dados[(i, 3)],
            dados[(i, 4)]])

print("=============")
print("Fim do script")