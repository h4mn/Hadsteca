#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Modulo: encapsula_param.py
Autor: Hadston Nunes
Data: 2024.04.24
Versão: 1.0

Descrição:
Este script encapsula o que estiver na memória do clipboard como parâmetro de uma função.

Movitvação:
Este script foi desenvolvido para atender a necessidade de 
colar um texto como parametro da função UpperCase do Delphi.

Uso:
    1. Deve ser definido na constante qual é a função a ser utilizada.
    2. Executar o script, onde <string> é o texto a ser encapsulado.

    python encapsula_param.py <string>
"""
import sys
import pyperclip

# Função a ser utilizada
# funcao = "UpperCase"
# funcao = "Lines.Add"
funcao = "Ord"
# schema = "{}('{}');"
schema = "{}({});"
string = ""

# Capturar a string do parametro
if len(sys.argv) == 2:
    string = sys.argv[1]

# Validar se tem string no parametro
if not string:
    # Se não tiver, verificar se tem algo no clipboard
    string = pyperclip.paste()
    
# Formatar a saida
saida = schema.format(funcao, string)

# Enviar para o clipboard o resultado
pyperclip.copy(saida)

# Imprimir a string em maiúsculas
print(saida)