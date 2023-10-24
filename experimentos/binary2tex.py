
''' Converte binario para texto
'''
class Binario:
    def ToText(self, codigo):
        for i in range(0, len(codigo), 8):
            b = codigo[i:i+8]
            print(chr(int(b,2)), end="")
            pass
        pass
    pass

b = Binario()
b.ToText("01110011011001010111001001110000011100100110111101100111011100100110000101101101011000010110010001101111011100100110010101110110011010010110010001100001")
pass