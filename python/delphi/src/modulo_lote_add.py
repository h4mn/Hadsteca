# Cabeçalho
# Autor: Hadston Nunes
# Data: 2024.05.22
# Versão: 1.0
#
# Descrição:
# Este script adiciona módulos em lote em vários arquivos uT_Modulo.pas.
#
# Movitvação:
# Este script foi desenvolvido para atender a necessidade de adicionar de forma mais rápida módulos em lote em vários arquivos uT_Modulo.pas.
#
# Convencão:
# Este é um módulo do arquivo uT_Modulo.pas. Ele é um registro que contém as informações de um módulo.
# ```pas
# GMovFinanceiroTest : TSysModulo =
# (
#   DESCRICAO : 'CTA. CORRENTE - MOVIMENTAÇÃO FINANCEIRA';
#   MODULO    : 'TfMov_Financeiro';

#   TIPO      : TpMdl_AcessoTela;
#   GRUPO     : TpMdlGrp_Movimentacao;
#   SUBGRUPO  : TpMdlSbGrp_Financeiro;
#   SISTEMA   : TpMdlSistTipo_FuturaServer;
#   PERMISSAO : PrmssMdl_Acesso_Novo_Editar_Excluir;
#   REFERENTE : '';
# );
# ```
#
# Ele trabalha em conjunto com sua linha correspondente no procedimento que o adiciona a uma lista.
# ```pas
# AddSysModulo(GMovFinanceiroTest);
# ```
#
# Quando um novo módulo é adicionado, ele deve ser adicionado a vários uT_Modulo.pas. Este script automatiza este processo. Vamos receber um parâmetro que é o nome do módulo anterior a posição que vamos adicionar o novo módulo. Se não recebermos este parâmetro, o módulo será adicionado no final, após o último módulo.
#
# Estrutura da classe:
# - Receber o nome do módulo anterior;
# - Receber um struct com os dados do módulo (nome, descrição, modulo, tipo, grupo, subgrupo, sistema, permissao, referente);
# - Receber um array de paths de arquivos uT_Modulo.pas;
# - Adicionar o módulo em cada arquivo uT_Modulo.pas.
#
# Uso:
# Chamada através de classe de teste.

import sys
import os
import re
import time
from datetime import datetime

# Biblioteca que pinte o texto no console, mas com mais opções, por exemplo, parte do texto negrito.
from colorama import Fore, Back, Style
# Instalar:
# pip install colorama
# Exemplo de uso:
# print(Fore.RED + 'some red text' + Fore.GREEN + ' with green text')


class ModuloLoteAdd:


  def __init__(self, nome_modulo_anterior, modulo, paths=[]):
    self.nome_modulo_anterior = nome_modulo_anterior
    self.modulo = modulo
    self.paths = paths

  
  def add_modulo(self):
    for path in self.paths:
      self.add_modulo_in_file(path)
      time.sleep(2)


  def add_modulo_call(self):
    for path in self.paths:
      self.add_modulo_in_file_call(path)
      time.sleep(2)

  
  def backup_file(self, path, tipo="bloco"):
    particula_tipo = 'block'
    if tipo == "chamada":
      particula_tipo = 'call'

    path_backup = path.replace(".pas", f".{datetime.now().strftime('%Y%m%d%H%M%S')}.{particula_tipo}.bak")
    os.system(f"copy \"{path}\" \"{path_backup}\" >nul")

    if not os.path.exists(path_backup):
      print(f"Erro ao copiar o arquivo {path} para {path_backup}")
      return


  def add_modulo_in_file(self, path):
    self.backup_file(path)

    with open(path, "r") as file:
      lines = file.readlines()
    
    new_lines = []
    inside_block = False
    for line in lines:
      # Se o módulo já existe no arquivo, não adiciona.
      if self.modulo["NOME"] in line:
        print(f"  Módulo {Style.BRIGHT}{self.modulo['NOME']}{Style.RESET_ALL} já existe no arquivo {Fore.CYAN}{path}{Fore.RESET}")
        return

      new_lines.append(line)

      if not inside_block:
        # Se eu não estou dentro do bloco, eu procuro pelo início do bloco.
        bloco_inicio = re.search(rf"{self.nome_modulo_anterior}\s*:\s*TSysModulo\s*=", line)
        if bloco_inicio:
          inside_block = True
      else:
        # Se eu estou dentro do bloco, eu procuro pelo fim do bloco.
        bloco_fim = re.search(r"\);", line)
        if bloco_fim:
          # Ao encontrar o fim do bloco, eu adiciono o novo módulo e reinicio a busca pelo início do bloco.
          inside_block = False
          new_lines.append('\n')
          new_lines.append(self.get_modulo_string())

      # TODO: Se não encontrar o nome do módulo anterior, encontrar o último bloco e adicionar o novo módulo após ele.
    
    with open(path, "w") as file:
      file.writelines(new_lines)
    
    # TODO: Verificar se o módulo foi adicionado corretamente.
    print(f"  Módulo {Style.BRIGHT}{self.modulo['NOME']}{Style.RESET_ALL}\n\t adicionado no arquivo {Fore.CYAN}{path}{Fore.RESET}")


  def add_modulo_in_file_call(self, path):
    self.backup_file(path, tipo="chamada")
    
    with open(path, "r") as file:
      lines = file.readlines()

    new_lines = []

    for line in lines:
      # TODO: Se a chamada já existe no arquivo, não adiciona.
      new_lines.append(line)

      if f"AddSysModulo({self.nome_modulo_anterior})" in line:
        new_lines.append(f"  AddSysModulo({self.modulo['NOME']});\n")

      # TODO: Se não encontrar a chamada do módulo anterior, encontrar a última chamada e adicionar a chamada do novo módulo após ela.
      
    with open(path, "w") as file:
      file.writelines(new_lines)

    # TODO: Verificar se a chamada foi adicionada corretamente.
    print(f"  Chamada {Style.BRIGHT}AddSysModulo({self.modulo['NOME']}){Style.RESET_ALL}\n\t adicionado no arquivo {Fore.CYAN}{path}{Fore.RESET}")

  
  def get_modulo_string(self):
    return f"  {self.modulo['NOME']} : TSysModulo =\n" + \
      "  (\n" + \
      f"    DESCRICAO : '{self.modulo['DESCRICAO']}';\n" + \
      f"    MODULO    : '{self.modulo['MODULO']}';\n" + \
      f"    TIPO      : {self.modulo['TIPO']};\n" + \
      f"    GRUPO     : {self.modulo['GRUPO']};\n" + \
      f"    SUBGRUPO  : {self.modulo['SUBGRUPO']};\n" + \
      f"    SISTEMA   : {self.modulo['SISTEMA']};\n" + \
      f"    PERMISSAO : {self.modulo['PERMISSAO']};\n" + \
      f"    REFERENTE : '{self.modulo['REFERENTE']}';\n" + \
    "  );\n"
