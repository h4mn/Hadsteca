#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Modulo: upper_case.py
Autor: Hadston Nunes
Data: 2024.03.27
Versão: 1.0

Descrição:
Este script converte uma cadeia de caracteres em maiúsculas.

Movitvação:
Este script foi desenvolvido para atender a necessidade de converter 
uma cadeia de caracteres em maiúsculas das variáveis de formulário do
arquivo 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Geral\\Geral\\Outro\\RnGenerico\\uT_MainValidaForm.pas'.

Uso:
    python upper_case.py <string>
"""
import sys
import pyperclip

# String padrão
string = "ifOtr_BackupeRestaure"

# Capturar a string do parametro
if len(sys.argv) == 2:
    string = sys.argv[1]

# Converter a string para maiúsculas
upper_case = string.upper()

# Enviar para o clipboard o resultado
pyperclip.copy(upper_case)

# Imprimir a string em maiúsculas
print(upper_case)