''' Converte mascara para fones e celular
'''
import re

class FoneMask:
    def get_number(self, numero):
        return ''.join(re.findall(r'\d+', numero.strip()))
        pass
    def teste(self, numero):
        n = self.get_number(numero)

        # Sem DDD
        if len(n) == 8:
            abcde = n[:4]
            mcdu = n[4:8]
            r = '{}-{}'.format(abcde, mcdu)
            pass
        elif len(n) == 9:
            abcde = n[:5]
            mcdu = n[5:9]
            r = '{}-{}'.format(abcde, mcdu)
            pass
        # Com DDD
        elif len(n) == 10:
            ddd = n[:2]
            abcde = n[2:6]
            mcdu = n[6:10]
            r = '({}) {}-{}'.format(ddd, abcde, mcdu)
            pass
        elif len(n) == 11:
            ddd = n[:2]
            abcde = n[2:7]
            mcdu = n[7:11]
            r = '({}) {}-{}'.format(ddd, abcde, mcdu)
            pass
        else:
            r = '{}'.format(n)
        return r
        pass
    pass

f = FoneMask()
print(f.teste("(11)98894-1273"))
print(f.teste("(19) 98894-1273"))
print(f.teste("98894-1273"))
print(f.teste("(19) 3473-1273"))
print(f.teste("(21)3473-1273"))
print(f.teste("3473-1273"))
print(f.teste("(19)98888-55555"))