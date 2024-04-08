# -*- coding: utf-8 -*-
import os
import re

class SearchStringInFile(object):
    '''
    Esta classe pesquisa string num arquivo 
    gerado pelo Grep Search (uma ferramenta de pesquisa do delphi)

    Todo:
    1. ler arquivo grep;
    2. encontrar padrão pelo regex;
    3. imprimir:
    3.a nome da unit contendo a string pesquisada;
    3.b linha contendo a string
    
    '
    Ex 1:
    -- teste inicial: '.*kiosk.*' (o objetivo inicial era localizar todas as strings
    kiosk e substituir pelo novo nome 'checkout' - tarefa 2937601)    
    C:\_Fontes\trunk\RepTmp\Geral\Geral\Configuracao\InterfaceGenerico\ifOtr_ImportarToken.dfm
      5	Caption = 'Sele'#231#227'o de Token Kiosk - [ESC] para sair'
    '
    
    Ex 2:
    -- procurar em todas as Line com a string 'Local' e 
    retornar o arquivo em que a string está contida
    '
    '''
    #file_grep_results = 'C:\\_tmp\\GxGrep.HistoryList'
    file_grep_results = 'C:\\_tmp\\_txt\\GxGrep.HistoryList_local.txt'
    

    def get_file(self):
        with open(self.file_grep_results, 'r') as file:
            print('arquivo lido')
            return file.read().rstrip()
        pass

    pass


tarefas = {
    0: {'os':'A','id':'11069','nome':'25IMPORTADORES B2B MARKETPLACE'},
    1: {'os':'A','id':'2853','nome':'BOQUETAO REFRIGERACAO EIRELI'},
    2: {'os':'A','id':'3609','nome':'CENTER UTIL - UTILIDADES E PRESENTE LTDA - ME'},
    3: {'os':'A','id':'10354','nome':'FMC - UTILIDADES DOMESTICAS - EIRELI'},
    4: {'os':'A','id':'6951','nome':'GLADYS COMERCIO DE ARTIGOS RELIGIOSOS LTDA'},
    5: {'os':'A','id':'1595','nome':'REGINALDO DE BRITO GONÇALVES'},
    6: {'os':'A','id':'8982','nome':'TNUVA COMERCIO DE PRODUTOS ALIMENTICIOS LTDA'},
    7: {'os':'A','id':'9113','nome':'VANTAJ ALBATROZ DIST.DE BRINQ. E UTIL. DOMÉSTICAS LTDA.'},
    8: {'os':'A','id':'325','nome':'ZL MERCADO E COMERCIO DE PRODUTOS ALIMENTICIOS LTDA - EPP'},
    9: {'os':'I','id':'11069','nome':'25IMPORTADORES B2B MARKETPLACE'},
    10: {'os':'I','id':'10354','nome':'FMC - UTILIDADES DOMESTICAS - EIRELI'},
    11: {'os':'I','id':'9113','nome':'VANTAJ ALBATROZ DIST.DE BRINQ. E UTIL. DOMÉSTICAS LTDA.'},
}

class Teste:
    def __init__(self, path):
        # for p, _, files in os.walk(os.path.abspath(path)):
        #     for file in files:
        #         print(os.path.join(p, file))
        for pasta in os.listdir(path):
            alias = re.findall(r'^([\d]+)\s-\s(.*)$', pasta)
            #publicado = alias[0][0]
            if alias != []:
                print(alias)
            #     for i in range(0, len(tarefas) - 1):
            #         if tarefas[i]['id'] == alias[0][0]:
            #             #print(alias, tarefas[i]['os'])
            #             pass
            #         else:
            #             if tarefas[i]['id'] != []:
            #                 print(alias, tarefas[i]['os'])
            #                 pass
            #             break
            #         pass
                pass
        pass
    pass

if __name__ == "__main__":
    # s = SearchStringInFile()
    # s.get_file()
    t = Teste('G:\\11 - AplicativoDoConsumidor')
    pass