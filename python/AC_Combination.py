"""_gpt_summary_
Este script em Python utiliza a biblioteca itertools para gerar todas as combinações possíveis de 6 elementos a partir de uma lista de 10 elementos.

O script começa importando a função combinations da biblioteca itertools e, em seguida, define uma lista de 10 elementos chamada "lista".

O script então usa a função combinations para gerar todas as combinações possíveis de 6 elementos a partir da lista "lista". O resultado é armazenado na variável "comb".

O script então itera sobre cada combinação gerada e imprime o número da combinação e seus elementos correspondentes.

O resultado final é uma lista de todas as combinações possíveis de 6 elementos a partir da lista "lista".
"""
from itertools import combinations
'''
6,11,13,45,7,42,38,28,23,54
'''
#lista = [6,11,13,45,7,42,38,28]
lista = [6,7,11,13,28,38,39,42,45,49,54]
comb = combinations(lista, 6)

counter = 0
for i in list(comb):
    counter+=1
    print("%d: %s" % (counter,i))
