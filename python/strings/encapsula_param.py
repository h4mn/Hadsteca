#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Modulo: encapsula_param.py
Autor: Hadston Nunes
Data: 2024.04.24
Versão: 1.1

Histórico de versões:
1.0 - 2024.04.24 - Hadston Nunes
    - Versão inicial - procedural.
1.1 - 2024.05.21 - Hadston Nunes
    - Versão orientada a objetos.

Descrição:
Este script encapsula o que estiver na memória do clipboard como parâmetro de uma função.

Movitvação:
Este script foi desenvolvido para atender a necessidade de 
colar um texto como parametro da função UpperCase do Delphi.

Uso:
    1. Deve ser definido na constante qual é a função a ser utilizada.
    2. Executar o script, onde <string> é o texto a ser encapsulado.

    Ex.:
        - Se a função for UpperCase:
            Comando: python encapsula_param.py "Hello World"
            Saída: UpperCase('Hello World');
        - Se a função for Lines.Add:
            Comando: python encapsula_param.py "Hello World"
            Saída: Lines.Add('Hello World');
        - Se a função for Ord e o schema for "{}({});":
            Comando: python encapsula_param.py "TCadTipo.Codigo"
            Saída: Ord(TCadTipo.Codigo);

    python encapsula_param.py <string>
"""
import sys
import pyperclip
import re

class EncapsulaParam:
    def __init__(self, funcao, schema):
        self.funcao = funcao
        self.schema = schema
        self.string = ""
        self.get_string()

    def get_string(self):
        if len(sys.argv) == 2:
            self.string = sys.argv[1]

        if not self.string:
            self.string = pyperclip.paste()
    
    def encapsula(self):
        saida = self.schema.format(self.funcao, self.string)
        pyperclip.copy(saida)
        print(saida)


class ReplaceStringDelphi:
    def __init__(self):
        self.string = ""
        self.get_string()

    def get_string(self):
        if len(sys.argv) == 2:
            self.string = sys.argv[1]

        if not self.string:
            self.string = pyperclip.paste()
    
    def limpa(self):
        # saida = self.string.replace("+#13+", "").replace("'", "")
        # Limpa usando grupo regex pra retornar apenas a parte interna sem o separador de string do delphi.
        # String de teste
        # +#13+'from PEDIDO_ITEM PIt'
        match = re.search(r"\s*[\+\#\d']+(.*)'", self.string)
        if match:
            saida = match.group(1)
        else:
            saida = self.string

        pyperclip.copy(saida)
        print(saida)

    def encapsula(self):
        schema = "+#13+'{}'"
        saida = schema.format(self.string)
        pyperclip.copy(saida)
        print(saida)


if __name__ == "__main__":

    caso_de_uso = "ReplaceStringDelphi"

    if caso_de_uso == "UpperCase":
        """
        - Se a função for UpperCase:
            Comando: python encapsula_param.py "Hello World"
            Saída: UpperCase('Hello World');
        """
        e = EncapsulaParam("UpperCase", "{}('{}');")
        e.encapsula()

    elif caso_de_uso == "Lines.Add":
        """
        - Se a função for Lines.Add:
            Comando: python encapsula_param.py "Hello World"
            Saída: Lines.Add('Hello World');
        """
        e = EncapsulaParam("Lines.Add", "{}('{}');")
        e.encapsula()

    elif caso_de_uso == "Ord":
        """
        - Se a função for Ord e o schema for "{}({});":
            Comando: python encapsula_param.py "TCadTipo.Codigo"
            Saída: Ord(TCadTipo.Codigo);
        """
        e = EncapsulaParam("Ord", "{}({});")
        e.encapsula()

    elif caso_de_uso == "ReplaceStringDelphi":
        """
        - Se a função for ReplaceStringDelphi:
            Comando: python encapsula_param.py "+#13+'from PEDIDO_ITEM PIt' "
            Saída: from PEDIDO_ITEM PIt;
        """
        r = ReplaceStringDelphi()
        # r.limpa()
        r.encapsula()
