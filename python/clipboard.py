# Biblioteca para uso da Area de transferencia
from tkinter import Tk

def set_clipboard(saida):
    cb = Tk()
    cb.withdraw()
    cb.clipboard_clear()
    cb.clipboard_append(saida)
    cb.update()
    cb.destroy()
    pass

set_clipboard( 'teste' )