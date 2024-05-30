"""_summary_
Criar um script que lê este arquivo e copia seu conteúdo para o clipboard.

Obs.: Testar e melhorar, depois.
"""
import os

class File(object):
    def __init__(self, path):
        self.path = path
        self.content = ''
        self.read()
        pass
    def read(self):
        with open(self.path, 'r') as f:
            self.content = f.read()
            pass
        pass
    def set_clipboard(self):
        os.system("echo '%s' | xclip -selection clipboard" % self.content)
        pass
    pass

f = File('/home/hadson/Documentos/Python/hadsteca/hadsteca/hellos/open_file2clipboard.py')