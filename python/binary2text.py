"""
Fiz esta classe para converter binario para texto a algum tempo atrás. Agora, olhando para ela, percebi que posso refatorar ela usando código limpo.

Então, resolvi criar um decorador (que eu aprendi a pouco tempo) para demonstrar as duas versões, a antiga e a nova, sem e com código limpo, respectivamente.

Hadston Nunes
2023.10.31
"""


class Decorador:
    """Classe decoradora para demonstrar seu uso na comparação de duas versões do mesmo código.
    """

    def codigo_sujo(self, comentario):
        def wrapper(func):
            def inner(*args, **kwargs):
                print(f"\n===========================================")
                print(f"Versão suja: {comentario}")
                return func(*args, **kwargs)
            return inner
        return wrapper

    def codigo_limpo(self, comentario):
        def wrapper(func):
            def inner(*args, **kwargs):
                print(f"\n===========================================")
                print(f"Versão limpa: {comentario}")
                return func(*args, **kwargs)
            return inner
        return wrapper

decorador = Decorador()


class Binario:
    ''' Converte binario para texto
    '''

    @decorador.codigo_sujo("Primeira versão, precisa de refatoração.")
    def ToText(self, codigo):
        for i in range(0, len(codigo), 8):
            b = codigo[i:i+8]
            print(chr(int(b,2)), end="")

    @decorador.codigo_limpo("Versão refatorada, com código limpo.")
    def to_text(self, sequencia_em_binario):
        inicio = 0
        passo = 8
        no_breakline = ""

        for i in range(inicio, len(sequencia_em_binario), passo):
            byte = sequencia_em_binario[i:i+8]
            print(chr(int(byte,2)), end=no_breakline)


if __name__ == "__main__":
    b = Binario()

    b.ToText("01110011011001010111001001110000011100100110111101100111011100100110000101101101011000010110010001101111011100100110010101110110011010010110010001100001")

    b.to_text(sequencia_em_binario="01110011011001010111001001110000011100100110111101100111011100100110000101101101011000010110010001101111011100100110010101110110011010010110010001100101")
