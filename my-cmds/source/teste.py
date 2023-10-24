import subprocess
import re

#dfm = 'C:\\_tmp\\_fontes\\trunk\\Empresa\\00000 - Generico\\Sistemas\\FuturaFiscal\\ifMain - Copia.dfm'
dfm = r'C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Sistemas\FuturaUtil\ifMain - Copia.dfm'

pas = 'C:\\_tmp\\_fontes\\trunk\\Empresa\\00000 - Generico\\Sistemas\\FuturaFiscal\\ifMain - Copia.pas'

def ler_pas(filename):
    """ Extrai lista de telas dos parametros do AddMenu do arquivo ifMain.pas
    """
    telas = []
    with open(filename, 'r') as arquivo:
        linhas = arquivo.readlines()
        for linha in linhas:
            linha = linha.strip()
            if linha.startswith('AddMenu('):
                parametros = re.findall(r'\((.*?)\)', linha)
                parametros = parametros[0].split(',')
                param_var = parametros[0]
                param_class = parametros[1]
                telas.append(f'{param_var}, {param_class}')
                pass
    return telas

def ler_dfm(nome_arquivo):
    """ Extrai lista de captions dos TMenuItem's do arquivo ifMain.dfm
    """
    estrutura_menu = []
    iniciado = False
    
    with open(nome_arquivo, 'r') as arquivo:
        linhas = arquivo.readlines()
        for linha in linhas:
            linha_raw = linha
            linha = linha_raw.strip()

            if linha.startswith('object MainMenu'):
                iniciado = True
                current_menu = []
            
            if iniciado:
                # if linha.endswith(': TMenuItem') and linha_raw.startswith('    '):
                #     nivel = 0
                #     caption = linha.split(':')[0].strip()
                #     while len(current_menu) > nivel:
                #         current_menu.pop()
                #     current_menu.append(caption)

                if linha.endswith(': TMenuItem'):
                    nivel = linha_raw.count('  ') - 1
                    caption = linha.split(':')[0].split(' ')[1].strip()
                    # while len(current_menu) > nivel:
                    #     current_menu.pop()
                    # current_menu.append(caption)

                if linha.startswith('Caption'):
                    nivel = linha_raw.count('  ') - 1
                    caption = linha.split('=')[1].strip().strip("'")
                    while len(current_menu) > nivel:
                        current_menu.pop()
                    current_menu.append(caption)

                if linha == 'end' and current_menu:
                    estrutura_menu.append(current_menu.copy())
                    current_menu.pop()

    return estrutura_menu

def importar_msinfo():
    # Executa o comando msinfo32.exe e redireciona a saída para um arquivo
    subprocess.run(['msinfo32.exe', '/report', r'Z:\Backup\_tmp\_txt\teste.txt'], shell=True)


# Exemplo de uso:
# estrutura_menu = ler_dfm(dfm)
# for menu in estrutura_menu:
#     # nivel = len(menu) - 1
#     # print('   ' * nivel + ' > '.join(menu))
#     print(menu)

# telas = ler_pas(pas)
# for tela in telas:
#     print(tela)


# Chama a função para importar o resultado do MSInfo
importar_msinfo()
