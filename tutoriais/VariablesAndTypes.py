'''
Curso de Python Autodidata
==========================
Data: 20210119
Referências:
- https://www.learnpython.org/en/Variables_and_Types
- http://excript.com/python/comentarios-em-python.html
- https://docs.python.org/pt-br/3/tutorial/inputoutput.html
'''
# Type Int
myint = 7
print ('Type Int:          {0}'.format(myint))

# Type Float
myfloat = 7.0
print (f'Type Float: {myfloat:10}')
myfloat = float(myint)
print (f'Type Cast Float:{myfloat:6}')

# Type String
mystring = 'hello'
print (f'Type String: {mystring}')
mystring = "Don't worry"
print (f'Type String: {mystring}')

# Mixing Types
myvariant = 1 + 2
print (f'Type Mixing: {myvariant:7}')
myvariant = '1' + '2'
print (f'Type Mixing: {myvariant}')
myvariant = 1 + 2
print (f'Type Mixing: {myvariant}' + ' - ' + mystring)