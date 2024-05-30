#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
Gerador de template padrão de SQL Execute Block
Descrição:
Ferramenta para geração automática de um template padrão de SQL Execute Block.
Esta ferramenta foi desenvolvia para ajudar a debugar sql com parâmetros.
Referencias:
- https://www.askpython.com/python/examples/add-a-newline-character-in-python
- https://realpython.com/python-string-split-concatenate-join/
- https://stackoverflow.com/questions/6289474/working-with-utf-8-encoding-in-python-source
- https://book.pythontips.com/en/latest/ternary_operators.html
- https://stackoverflow.com/questions/11063458/python-script-to-copy-text-to-clipboard
- https://docs.python.org/3/tutorial/classes.html
- https://www.programiz.com/python-programming/docstrings
- https://realpython.com/python-main-function/
- https://stackoverflow.com/questions/625083/what-init-and-self-do-in-python
- https://stackoverflow.com/questions/3391076/repeat-string-to-certain-length
- https://www.tutorialspoint.com/increment-and-decrement-operators-in-python#:~:text=On%20incrementing%20the%20value%20of,%2B%2B%2F%2D%2D%20operator.
Autor:
Hadston Nunes

Versão-Atualização:
2023.07.14.12.24

'''
from tkinter import Tk # Biblioteca para uso da Area de transferencia (COM PROBLEMA)
import pyperclip # Biblioteca para uso da Area de transferencia


#==================================================
# Quantidade de parametros sql do ExecuteBlock
QUANTIDADE_PARAMETROS = 13
#==================================================
# Quantidade de tabulações padrão
QUANTIDADE_TABULACOES = 9
#==================================================


class SQL_ExecuteBlockReturns(object):
    '''
    SQL_ExecuteBlockReturns:
        Classe para geração automática de um template padrão de SQL Execute Block.
    '''

    def __init__(self):
        self.tabs = '\t' * QUANTIDADE_TABULACOES
        pass

    '''
    set_tabs:
        altera a quantidade de tabulações
        Parameters:
            count: numero de quantidades de tabulações
    '''
    def set_tabs(self, count):
        if count == 0:
            count = QUANTIDADE_TABULACOES
            pass

        self.tabs = '\t' * count
        pass

    '''
    get_parametros:
        gera os parametros do execute block
        Parameters:
            bloco: numero do bloco
                - 0 para "r_01 varchar(100)"
                - 1 para ":r_01"
        Returns:
        retorna os parametros do execute block
    '''
    def get_parametros(self, bloco):
        retorno = ''

        for x in range(QUANTIDADE_PARAMETROS + 1):
            bloco_texto = [
                f'r_{x:02d} blob sub_type text',
                f':r_{x:02d}',
                f'({x:02d})r_{x:02d}'
            ]

            if x > 0:
                if x == 1:
                    retorno = retorno + self.tabs + bloco_texto[bloco].format(x) + '\n'
                    pass
                else:
                    retorno = retorno + self.tabs +',' + bloco_texto[bloco].format(x) + '\n'
                    pass
                pass

        return retorno
    pass

def main():
    '''
    main:
        plota execute block padrao com os parametros pedidos
    '''    
    saida = ''
    # cb = Tk()
    # cb.withdraw()
    # cb.clipboard_clear()


    sql = SQL_ExecuteBlockReturns()
    sql.set_tabs(1)
    saida = 'set term #;\n'
    saida = saida + 'execute block\n'
    saida = saida + 'returns (\n'
    saida = saida + sql.get_parametros(0)
    saida = saida + '\t--r_optional blob sub_type binary\n'
    saida = saida + ') as\n'
    saida = saida + '\n'
    saida = saida + "declare variable TEXTO     varchar(100)         = 'TEXTO';\n"
    saida = saida + "declare variable DATA_INI  date                 = '01/01/2021';\n"
    saida = saida + "declare variable DATA_FIM  date                 = '01/31/2021';\n"
    saida = saida + '\n'
    saida = saida + "declare variable ID   integer              = 0;\n"
    saida = saida + "declare variable ConjuntoIDs  blob sub_type text   = '222803,222703,222603,217103,217003,214603,208703,205103,201503,194603';\n"
    saida = saida + '\t--==================================================\n'
    saida = saida + '\n'
    saida = saida + 'begin\n'
    saida = saida + '\tfor\n'
    saida = saida + '\t--==================================================\n'
    saida = saida + '\n'
    saida = saida + 'select\n'
    saida = saida + sql.get_parametros(2)
    saida = saida + 'from RDB$DATABASE\n'
    saida = saida + '\n'
    saida = saida + '\t--==================================================\n'
    saida = saida + '\tinto\n'
    sql.set_tabs(2)
    saida = saida + sql.get_parametros(1)
    saida = saida + '\tdo\n'
    saida = saida + '\tbegin\n'
    saida = saida + '\t\tsuspend;\n'
    saida = saida + '\tend\n'
    saida = saida + 'end#\n'
    saida = saida + 'set term ;#'
    
    # cb.clipboard_append(saida)
    pyperclip.copy(saida)
    
    print(sql.__doc__)
    print('Template enviado para a Área de Transferência! ;)')
    
    # cb.update()
    # cb.destroy()
    pass

if __name__ == "__main__":
    main()
    pass
