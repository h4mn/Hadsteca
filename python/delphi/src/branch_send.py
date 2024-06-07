# Cabeçalho
# Este script envia arquivos (*.pas, *.dfm e *.fmx) para branchs anteriores.
# Autor: Hadston Nunes
# Data: 2024.05.23.12.30
# Versão: 1.2 (bat refatorado para python)
#

# esqueleto da classe
class Branch:
  def __init__(self, dados):
    self.dados = dados
    self.nome = ""
    self.path = ""
