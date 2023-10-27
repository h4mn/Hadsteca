import sys
import re
import datetime as dt
import argparse

class Log:
    @staticmethod
    def __new__(cls, mensagem):
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
        
    def remover_unidades_duplicadas(caminho_arquivo):
        with open(caminho_arquivo, 'r') as arquivo:
            linhas = arquivo.readlines()

        unidades = set()
        novas_linhas = []

        for linha in linhas:
            if linha.strip().startswith('uses'):
                # Verifica se a linha contém a declaração de units
                unidades = set(linha.strip().split(',')[1:-1])

                # Adiciona a linha original sem unidades duplicadas
                novas_linhas.append(linha)
            elif not any(unit in linha for unit in unidades):
                # Adiciona outras linhas que não têm declarações de units duplicadas
                novas_linhas.append(linha)

        with open(caminho_arquivo, 'w') as arquivo:
            arquivo.writelines(novas_linhas)


# Main existe porque o script é chamado diretamente do terminal
# por outro script cmd (copiar_atalho_relativo_2023.10.bat)
if __name__ == '__main__':
    delphi_dpr = DelphiDPR()
    delphi_dpr.unit_add()
