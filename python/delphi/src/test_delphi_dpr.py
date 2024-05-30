import unittest
import delphi_dpr
from rich.console import Console
import datetime as dt
import os

class Log():
    @staticmethod
    def __new__(cls, mensagem):
        console = Console()
        console.print(f'[green][{dt.datetime.now()}] {mensagem}[/green]')

class TestDelphiDPR(unittest.TestCase):
    def setUp(self):
        self.delphi_dpr = delphi_dpr.DelphiDPR()
        this_path = os.path.dirname(os.path.abspath(__file__))
        self.file_dpr = os.path.join(this_path, 'testes/teste.dpr')
        Log(f'file_dpr: {self.file_dpr}')
    
    # def test_unit_add(self):

    #     # arrange
    #     file_pas = 'experimentos/delphi/testes/arquivos/teste.pas'
    #     linhas_origem = [
    #         '  experimentos/delphi/testes/arquivos/teste1.pas,\n',
    #         '  experimentos/delphi/testes/arquivos/teste2.pas,\n',
    #         '  experimentos/delphi/testes/arquivos/teste3.pas;\n',
    #     ]

    #     # act
    #     # self.delphi_dpr.unit_add(self.file_dpr, file_pas)
        
    #     # assert
    #     with open(self.file_dpr, 'r') as f:
    #         linhas = f.readlines()
    #         assert linhas[6]  == linhas_origem[0]
    #         assert linhas[7]  == linhas_origem[1]

    def test_remove_duplicated(self):

        # arrange
        is_duplicated = False

        # act
        self.delphi_dpr.remove_duplicated(self.file_dpr)

        # assert
        with open(self.file_dpr, 'r') as arquivo:
            # retornar path do arquivo
            Log(f'arquivo_path: {arquivo.name}')

            linhas = arquivo.readlines()

            # iterar todas as linhas do arquivo
            for i in range(len(linhas)):
                # pra cada linha, iterar novamente todas as linhas do arquivo
                for j in range(len(linhas)):

                    # se a linha não for ela mesma
                    if i == j:
                        continue

                    # e for diferente de nada
                    if linhas[i] == '\n':
                        continue

                    # e se a linha i for igual a linha j
                    if linhas[i] == linhas[j]:
                        # a linha i é duplicada
                        is_duplicated = True
                        break

                # se a linha é duplicada, sair do loop
                if is_duplicated:
                    break
            
        # se a linha é duplicada, o teste falha
        self.assertFalse(is_duplicated)
        pass


if __name__ == '__main__':
    try:
        unittest.main()
    except SystemExit as e:
        Log(f'=================================')
        Log(f'exit: {e}')
    pass