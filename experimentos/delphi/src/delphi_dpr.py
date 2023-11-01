import sys
import re
import datetime as dt
import argparse
from rich.console import Console

class Log:
    @staticmethod
    def __new__(cls, mensagem):
        console = Console()
        console.print(f'[green][{dt.datetime.now()}][/green] {mensagem}')
        with open('delphi_dpr.log', 'a') as f:
            f.write(f'[{dt.datetime.now()}] {mensagem}\n')


class DelphiDPR:
    def __init__(self):
        self.dpr_path = None
        self.unit_path = None

    def unit_add(self):
        # validar se tem argumentos
        if len(sys.argv) < 3:
            print('Uso: python delphi_dpr.py <arquivo_dpr> <nova_unidade>')
            print('=======================================================')
            sys.exit(1)
        
        self.dpr_path = sys.argv[1]
        self.unit_path = sys.argv[2]

        Log(f'dpr_path: {self.dpr_path}')
        Log(f'unit_path: {self.unit_path}')

        if not self.dpr_path.endswith('.dpr'):
            if self.dpr_path.endswith('.dproj'):
                self.dpr_path = self.dpr_path.replace('.dproj', '.dpr')
            else:
                raise Exception('Extensão do arquivo DPR inválida')

        with open(self.dpr_path, 'r') as f:
            linhas = f.readlines()
        
        flag_uses = False
        flag_ultima_declaracao = False

        for i in range(len(linhas)):
            if linhas[i] == 'uses\n':
                flag_uses = True

            if flag_uses and linhas[i].endswith(';\n'):
                flag_ultima_declaracao = True

            if flag_ultima_declaracao:
                linhas[i] = linhas[i].rstrip(';\n') + ',\n'
                linhas.insert(i+1, f'  {self.unit_path};\n')
                break

        with open(self.dpr_path, 'w') as f:
            f.writelines(linhas)
        
    def remove_duplicated(self, caminho_arquivo):
        with open(caminho_arquivo, 'r') as arquivo:
            linhas = arquivo.readlines()
            linhas_corrigidas = linhas.copy()

        contador = 0
        removidos = 0
        repetidas = []

        for i in range(len(linhas)):
            for j in range(len(linhas)):
                # se não for ela mesma
                if i == j:
                    continue

                # e for diferente de nada
                if linhas[i] == '\n':
                    continue

                # e se ainda não foi removidada
                if removidos > 0:
                    continue

                # e for exatamente igual a outra linha
                if linhas[i] == linhas[j]:
                    # Log(f'linhas[{i,j}]: {linhas[i]},{linhas[j]}')
                    removidos += 1
                    linhas_corrigidas.pop(j)
                    contador += 1
                    repetidas.append(linhas[i])
                    break

        # with open(caminho_arquivo, 'w') as arquivo:
            # arquivo.writelines(linhas_corrigidas)

        Log(f'=================================')
        Log(f'linhas duplicadas removidas: {contador}')
        Log(f'=================================')
        Log(f'linhas duplicadas: {repetidas}')



# Main existe porque o script é chamado diretamente do terminal
# por outro script cmd (copiar_atalho_relativo_2023.10.bat)
if __name__ == '__main__':
    delphi_dpr = DelphiDPR()
    # delphi_dpr.unit_add()
