import pyperclip as clip # Biblioteca para uso da Area de transferencia

class Capitalization:
    def __init__(self, texto):
        self.texto = texto
        pass
    
    def upper(self):
        return self.texto.upper()

    def lower(self):
        return self.texto.lower()


# Teste
''' Converte o texto para minúscula
'''
texto_1= 'NÃO É POSSÍVEL ALTERAR A FORMA DE PAGAMENTO DE UM PEDIDO FATURADO!'
texto_2= 'ESTE PEDIDO NÃO FOI BAIXADO, PARA CANCELAR PAGAMENTOS USE F2!'
texto_3= 'NÃO É POSSÍVEL CANCELAR, O PEDIDO NÃO PERTENCE A ESTE CAIXA!'
texto_4= 'TfOtr_CustoMedioAtualiza'
teste = Capitalization(texto_4)
saida = teste.upper()
clip.copy(saida)
print(saida)

