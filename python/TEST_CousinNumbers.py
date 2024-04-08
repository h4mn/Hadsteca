# -*- coding: utf-8 -*-
from tkinter import Tk # Biblioteca para uso da Area de transferencia

class Cousin:
    """ Desenvolver algoritmo de numero primo e colar na area de transferencia
    """
    def teste(self, number_test):
        if number_test > 1:
            # créditos do for: by Github Copilot (https://www.programiz.com/python-programming/examples/prime-number)
            for i in range(2, number_test):
                if (number_test % i) == 0:
                    print(number_test, "is not a prime number")
                    print(i, "times", number_test//i, "is", number_test)
                    break
                else:
                    print(number_test, "is a prime number")
                    break
            pass
        print()
        pass
    pass


def main():
    np = Cousin()
    np.teste(5)
    pass

if __name__ == "__main__":
    main()
    pass