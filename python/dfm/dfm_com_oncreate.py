import os
import magic

# Preciso varrer todos os arquivos *.dfm de todos os diretórios e subdiretórios e verificar se a string 'OnCreate = FormCreate' está presente em alguma linha. Se estiver, preciso armazenar o nome completo do arquivo e o nome da classe que representa esta tela.
# Os arquivos *.dfm que preciso verificar são correspondentes aos arquivos *.pas que possuem as classes TfrmCadCliente, TfrmCadFornecedor, TfrmCadProduto, etc. Tenho estas classes numa lista de strings.

# Classe dfms_com_oncreate
# Atributos:
#   - workspace: caminho para a pesquisa de todos os arquivos *.dfm
#   - path: caminho do arquivo *.dfm
#   - class_name: nome da classe que representa a tela
#   - class_file: nome do arquivo *.pas que contém a classe
#   - lines: lista de linhas do arquivo *.dfm
#   - has_oncreate: booleano que indica se o arquivo *.dfm contém a string 'OnCreate = FormCreate'

class dfms_com_oncreate:
  # enumerador para armazenar os nomes de classes de telas a ser pesquisado
  class_names = {
    'TfMov_NotaFiscal',
    'TfImp_NotaFiscalCompraDevolucao',
    'TfMov_MercadoriaNaoEntregue',
    'TfMov_NotaFiscalRemessaImportacao',
    'TfMov_NotaFiscalRetornoRemessa',
    'TfMov_NotaFiscalConsumidorMod02',
    'TfMov_DevolucaoVendaPropria',
    'TfMov_NotaFiscalECFMod2D',
    'TfMov_NotaFiscalCupomFiscalMod59',
    'TfCns_SAT_CFe',
    'TfSel_NotaFiscalCancelar',
    'TfOtr_NotaFiscalCancelarSubs',
    'TfMov_NotaFiscalCorrecao',
    'TfOtr_NfeManifestacaoDestinatario',
    'TfOtr_NfeXMLToNotaFiscalImportacaoDiretorio',
    'TfMov_NotaFiscalEletronicaInutilizacao',
    'TfSel_NotaFiscalEletronicaContingencia',
    'TfOtr_NotaFiscalEletronicaConsultaServico',
    'TfSel_NotaFiscalEletronicaSendEmail',
    'TfOtr_NfeXMLImpEmitente',
    'TfOtr_OrganizaItemNota',
    'TfSel_NotaFiscalLoteGerar',
    'TFOtr_CopiaNotaFiscal',
    'TfOtr_NotaFiscalEletronicaReferenciada',
    'TfMov_NfeComprovanteEntrega',
    'TfMov_NotaServico',
    'TfSel_NotaServico',
    'TfImp_NotaServicoRetorno',
    'TfSel_NotaServicoCtaParcelaLote',
    'TFMov_MDFe',
    'TfSel_MDFeContingencia',
    'TfOtr_ManifestacaoDocumentoConsultaServico',
    'TfSel_MDFeEncerramento',
    'TfSel_MDFeCancelamento',
    'TFOtr_MDFeInclusaoCondutor',
    'TFOtr_MDFePagtoOperTransporte',
    'TfSel_MDFeConfirmacao',
    'TfOtr_LimpaInventario',
    'TfOtr_InventarioApuracaoST',
    'TfCad_InventarioSaldoInicial',
    'TfOtr_InventarioSintetico',
    'TfOtr_InventarioSinteticoIndustria',
    'TfOtr_SiscomexImportacao',
    'TfOtr_SiscomexImportacaoXML',
    'TfOtr_FiscalFechamento',
    'TFCns_NFPWebServiceProtocolo',
    'TFExp_NFPWebServiceEnvioArquivos',
  }
  STRING_A_PESQUISAR = 'OnCreate = FormCreate'

  def __init__(self, workspace):
    self.workspace = workspace
    self.all_files = []
    self.path = ''
    self.lines = []
    self.has_oncreate = False
    self.dfms = []
    self.class_name = ''
    self.dfms_com_oncreate = []

    # verificar se o caminho workspace existe
    if not os.path.exists(self.workspace):
      raise FileNotFoundError('Caminho não encontrado: {}'.format(self.workspace))

    # varrer todos os arquivos *.dfm de todos os diretórios e subdiretórios do workspace
    self.all_files = self.list_files(self.workspace)
    # filtrar apenas os arquivos *.dfm
    self.all_files = [f for f in self.all_files if f.endswith('.dfm')]
    
    # para cada arquivo *.dfm encontrado
    for self.path in self.all_files:
    
      # varrer todas as linhas de todos os arquivos *.dfm
      lines = []
      if magic.from_file(self.path, mime=True) == 'text/plain':
        with open(self.path, 'r') as file:
          for line in file:
            lines.append(line)

      self.lines = lines
    
      # verificar se a string 'OnCreate = FormCreate' está presente em alguma linha
      self.has_oncreate = self.find_string(self.lines)

      # se estiver, armazenar o nome completo do arquivo e o nome da classe que representa esta tela
      if self.has_oncreate:
          self.dfms.append(self.path)
    
    # para cada arquivo *.dfm adicionado à lista self.dfms
    for self.path in self.dfms:

      # extrair apenas o nome do arquivo *.dfm, exemplo: 'TfrmCadCliente.dfm', extrair 'TfrmCadCliente'
      self.class_name = os.path.basename(self.path).split('.')[0]

      # comparar o nome da classe extraído com os nomes das classes da minha lista de classes class_names
      if self.class_name in self.class_names:
        self.dfms_com_oncreate.append(self.path)

  # função para exibir a lista com os dfms que contém a string 'OnCreate = FormCreate'
  def listar_dfms_com_oncreate(self):
    if len(self.dfms_com_oncreate) == 0:
        return 'Nenhum arquivo *.dfm encontrado com a string pesquisada'
    else:
      for dfm in self.dfms_com_oncreate:
        print(dfm)    

  # função recursiva para varrer uma árvore de diretórios
  # e retornar uma lista com os arquivos encontrados
  def list_files(self, path):
    files = []
    for f in os.listdir(path):
        if os.path.isfile(os.path.join(path, f)):
            files.append(os.path.join(path, f))
        elif os.path.isdir(os.path.join(path, f)):
            files.extend(self.list_files(os.path.join(path, f)))
    return files

  # função para localizar a string a pesquisar em uma lista de linhas
  # e retornar uma lista com os nomes dos arquivos que contém a string
  def find_string(self, lines):
    files = []
    for line in lines:
        if STRING_A_PESQUISAR in line:
            files.append(line)
    return files

def main():
  # instanciar a classe dfms_com_oncreate
  # passar como parâmetro o caminho para a pesquisa de todos os arquivos *.dfm
  # o caminho deve ser o caminho do workspace do Delphi
  # exemplo: 'C:\Users\user\Documents\Embarcadero\Studio\Projects\Projeto'
  dfms = dfms_com_oncreate('C:\\_tmp\\_fontes\\trunk\\RepTmp\\Financeiro\\ContaReceber')

  # imprimir a lista com os dfms que contém a string pesquisada
  dfms.listar_dfms_com_oncreate
  pass

if __name__ == '__main__':
  main()

