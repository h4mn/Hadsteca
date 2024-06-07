#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Modulo: paschecker.py
Autor: Hadston Nunes
Data: 2024.05.15
Versão: 1.0

Descrição:

Este script checa em arquivos *.pas procurando determinada sequencia.

Funcionamento:

O script recebe como entrada um array de paths de arquivos *.pas e uma string de busca.
Esta string de busca pode ser de dois tipos:
- Simples: Um termo simples ou uma regex;

Exemplo de regex:
- ^\s*ShowMessage

- Complexa: Um json representando um registro de busca na seguinte estrutura:
  - project_uses: Lista de uses que estão no projeto .dpr;
  - classe: Nome da classe;
  - metodo: Nome do método;
  - termo: Termo de busca ou regex.

  Exemplo:
  {
    "project_uses": ["System.SysUtils", "Vcl.Forms"],
    "classe": "TForm1",
    "metodo": "Button1Click",
    "termo": "ShowMessage"
  }

O script irá buscar a string de busca em todos os arquivos *.pas e retornar o resultado. O resultado é um json com os seguintes campos:
- path: Caminho do arquivo;
- linha: Número da linha;
- conteudo: Conteúdo da linha.

Exemplo:
{
  "path": "C:/projetos/delphi/src/Unit1.pas",
  "linha": 10,
  "conteudo": "ShowMessage('Hello World');"
}

Movitvação:

Este script foi desenvolvido para atender a necessidade de
procurar determinada sequencias padrões em arquivos *.pas.

Uso:

  python paschecker.py "C:/projetos/delphi/src/Unit1.pas" "ShowMessage"

  1. Escrever um array de paths de arquivos *.pas;
  2. Escrever uma string de busca;
  3. Executar o script.
  4. O resultado será exibido no console.
  5. Clicar com Ctrl+clique no resultado para abrir o arquivo no editor de texto.

TODOs:

- Implementar Ctrl+clique para abrir o resultado num editor de texto (Ex.: VSCode, Delphi), na linha correta;
"""
import os
import re

# Lista dos nomes dos arquivos
files = [
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashBoletosNaoGeradosFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashBoletosRejeitadosFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashChequesAguardandoFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasAtrasadasFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasPagarCentroCustoFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasPagarSemanaFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasPrevistasFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasRealizadasFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasRealizadasGraficoFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasReceberCentroCustoFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasReceberSemanaFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasTopCredoresFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashContasTopInadimplentesFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashNroFichaFMX.pas',
	r'C:\_tmp\_fontes\trunk\RepTmp\Diverso\Util\Outros\InterfaceGenerico\FMX\iFrm_DashSaldoContaCorrenteFMX.pas',
]

# Dicionário para armazenar os resultados
results = {}

# Expressão regular para encontrar o método Carrega e o uso do parâmetro pPeriodoTipo
# pattern = re.compile(r"procedure\s+Carrega.*?\bpPeriodoTipo\b", re.DOTALL)
# pattern = re.compile(r"procedure\s+Carrega.*?\bend\b.*?\bpPeriodoTipo\b", re.DOTALL)
pattern = re.compile(r"procedure\s+Carrega.*?if\s+pPeriodoTipo\s*=\s*TDshbdPrdTp_Anual", re.DOTALL)

for file in files:
  with open(file, 'r') as f:
    content = f.read()
    match = pattern.search(content)
    results[file] = 'Sim' if match else 'Não'

# Imprime os resultados
for file, uses_param in results.items():
  name = os.path.basename(file)
  print(f"{name}\tUtiliza: {uses_param}")