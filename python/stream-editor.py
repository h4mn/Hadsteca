# Autor: Hadston
# Data: 2023.09.06
# Dependências: Python 3.11.1
# Descricao: Script para editar arquivos de texto em lote

import os

arquivos = [
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Fiscal\\NotaFiscal\\Selecao\\InterfaceLipel\\ifSel_NotaFiscalLoteGerar.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\PDV\\Outro\\InterfaceNipoCenter\\ifOtr_ModuloImpressao.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\PDV\\Outro\\InterfaceGenerico\\ifOtr_ModuloImpressao.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\PDV\\Outro\\InterfaceFarmacia\\ifOtr_ModuloImpressao.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\PDV\\Outro\\InterfaceEspecifica\\ifOtr_ModuloImpressao.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\PDV\\Outro\\InterfaceDoceVida\\ifOtr_ModuloImpressao.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceCasaSafari\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceCenterPanosFranquia\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceCristal\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceEditoraMartinari\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceFarmacia\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceFuturaNFE\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceGourmet\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceHandMarket\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceMultiArt\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceNewGoods\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceNipoCenter\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceSieger\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceVisualize\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceWRGA\\ifMov_VendaPedido.pas',},
    {'v': '1', 'caminho': 'C:\\_tmp\\_fontes\\trunk\\RepTmp\\Venda\\Pedido\\Movimento\\InterfaceXT\\ifMov_VendaPedido.pas',},
]


# enumerador para vscode e delphi
enum_ide = {
    'vscode': 1,
    'delphi': 2,
}

# função para abrir todos os arquivos no vscode ou delphi
def abrir_arquivos(arquivos, ide=enum_ide['vscode']):
    for arquivo in arquivos:
        if ide == enum_ide['vscode']:
            os.system(f'code {arquivo["caminho"]}')

        if ide == enum_ide['delphi']:
            os.system(f'start {arquivo["caminho"]}')


# main
if __name__ == '__main__':
    abrir_arquivos(arquivos, enum_ide['delphi'])