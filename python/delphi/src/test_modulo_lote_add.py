import unittest
# como instalar pytest: pip install pytest
from modulo_lote_add import ModuloLoteAdd
from colorama import Fore, Back, Style

class TestModuloLoteAdd(unittest.TestCase):
  def setUp(self):

    # Nome do módulo anterior ao que será adicionado
    self.nome_modulo_anterior = "GMovFinanceiro"

    # Dados do módulo que será adicionado
    self.modulo = {
      "NOME"      : "GMovFinanceiroExtrato",
      "DESCRICAO" : "CTA. CORRENTE - MOVIMENTAÇÃO FINANCEIRA/EXTRATO",
      "MODULO"    : "TfMov_ExtratoFinanceiro",
      "TIPO"      : "TpMdl_AcessoTela",
      "GRUPO"     : "TpMdlGrp_Movimentacao",
      "SUBGRUPO"  : "TpMdlSbGrp_Financeiro",
      "SISTEMA"   : "TpMdlSistTipo_FuturaServer",
      "PERMISSAO" : "PrmssMdl_Acesso_Editar_Excluir",
      "REFERENTE" : ""
    }

    # Paths dos arquivos uT_Modulo.pas em que o módulo será adicionado
    self.paths = [
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaServer\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaPDV\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaGourmetServer\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaGourmet\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaCash\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaFiscal\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaEFD\uT_Modulos.pas",
      r"C:\_tmp\_fontes\trunk\Empresa\00000 - Generico\Comum\FuturaOS\uT_Modulos.pas",
    ]

    # Instancia a classe ModuloLoteAdd
    self.mla = ModuloLoteAdd(
      nome_modulo_anterior=self.nome_modulo_anterior, 
      modulo=self.modulo,
      paths=self.paths
    )


  # Métodos para utilizar na classe de teste
  """
  assertEqual(a, b): Verifica se a é igual a b.
  assertNotEqual(a, b): Verifica se a não é igual a b.
  assertTrue(x): Verifica se x é verdadeiro.
  assertFalse(x): Verifica se x é falso.
  assertIs(a, b): Verifica se a é b.
  assertIsNot(a, b): Verifica se a não é b.
  assertIsNone(x): Verifica se x é None.
  assertIsNotNone(x): Verifica se x não é None.
  assertIn(a, b): Verifica se a está em b.
  assertNotIn(a, b): Verifica se a não está em b.
  assertIsInstance(a, b): Verifica se a é uma instância de b.
  assertNotIsInstance(a, b): Verifica se a não é uma instância de b.
  """


  def test_add_modulo(self):
    
    # Roda o método add_modulo
    self.mla.add_modulo()
    
    # Verifica se o MÓDULO foi adicionado em cada arquivo
    for path in self.paths:
      new_lines = ""
      with open(path, "r") as file:
        lines = file.readlines()
        new_lines = "".join(lines)
        
        self.assertIn(self.modulo["NOME"], new_lines, 
          f"\n\nO nome do módulo não foi encontrado no arquivo {path}\n\n")


  def test_add_modulo_call(self):
    
    # Roda o método add_modulo_call
    self.mla.add_modulo_call()

    # Verifica se a CHAMADA para o novo módulo foi adicionada em cada arquivo
    for path in self.paths:
      new_lines = ""
      with open(path, "r") as file:
        lines = file.readlines()
        new_lines = "".join(lines)

        self.assertIn(f"AddSysModulo({self.modulo['NOME']})", new_lines,
          f"\n\nA chamada para o novo módulo não foi encontrada no arquivo {path}\n\n")


if __name__ == "__main__":
  unittest.main(exit=False)
