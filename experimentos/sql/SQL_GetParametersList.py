#!/usr/bin/env python
# -*- coding: utf-8 -*-
from tkinter import Tk # Biblioteca para uso da Area de transferencia
import re

class SQL_GetParamList(object):
    '''
    Esta classe tem por objetivo
    - ler um arquivo sql
    - detectar os parametros
    - retornar uma lista de parametros

    Referencias:
    - Read File to String: https://stackoverflow.com/questions/8369219/how-to-read-a-text-file-into-a-string-variable-and-strip-newlines
    - Regex Group: https://stackoverflow.com/questions/40157550/python-regexp-groups-how-do-i-get-all-groups
    Autor:
    Hadston Nunes - 2021
    Erros:
    - Situação: Foi encontrado um erro: Ao rodar um SQL que tenha um mesmo parâmetro
    referenciado várias vezes, está saindo repetido no resultado. Sugestão: Fazer 
    uma filtragem para não repetir.
    '''
    sql_file_path = 'F:\\BACKUP\\Temp\\_sql\\'
    sql_file_path = sql_file_path + 'temp_2.sql'
    sql_file = ''

    def get_file_string(self):
        with open(self.sql_file_path, 'r') as file:
            #data = file.read().replace('\n', '')
            return file.read().rstrip()
        print('read_file')
        pass

    def get_params(self):
        return re.findall(r':([\w]+)', self.get_file_string())
        pass

    def set_clipboard(self):
        cb = Tk()
        cb.withdraw()
        cb.clipboard_clear()
        saida = ''

        for x in self.get_params():
            saida = saida + 'declare variable '+x+' blob sub_type text = \'\';\n'
            pass

        cb.clipboard_append(saida)
        print(saida)

        cb.update()
        cb.destroy()
    pass

def main():
    sql = SQL_GetParamList()
    print(sql.__doc__)
    print('Welsinho')
    sql.set_clipboard()
    pass

if __name__ == "__main__":
    main()
    pass