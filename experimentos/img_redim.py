"""Script para redimensionar imagens

Este script é uma classe Python que manipula imagens. Ele usa a biblioteca Python Imaging Library (PIL) para abrir e redimensionar imagens. A classe Imagem tem vários métodos para redimensionar imagens, incluindo redim, redim_w e redim_all_w. O método redim_all_w redimensiona todas as imagens em um diretório pela largura especificada. O script também tem um bloco if __name__ == "__main__": que cria uma instância da classe Imagem e redimensiona todas as imagens no diretório especificado.
"""
from PIL import Image
import os


class Imagem:
    """Classe para manipular imagens
    """
    def __init__(self, file, ext):
        """Inicializa a classe
        """
        self.img = Image.open(file)
        self.ext = ext
        self.dir, self.name = os.path.split(file)
        self.w = self.img.size[0]
        self.h = self.img.size[1]
        self.ratio = self.w / self.h

    def redim(self, w, h):
        """Redimensiona a imagem
        """
        if w / h != self.ratio:
            print("Proporção da imagem não é igual a proporção desejada")
        else:
            self.img = self.img.resize((w, h))

    def redim_w(self, w):
        """Redimensiona a imagem pela largura
        """
        h = int(w / self.ratio)
        self.img = self.img.resize((w, h))

    def redim_all_w(self, w):
        """Redimensiona todas imagens do diretorio pela largura
        """
        output = f"{self.dir}\{w}"
        if not os.path.exists(output):
            os.makedirs(output)
        
        for file in os.listdir(self.dir):
            if file.endswith(self.ext):
                img = Imagem(f"{self.dir}\{file}", self.ext)
                img.redim_w(w)
                img.save(f"{output}\{file}")

    def save(self, name):
        """Salva a imagem
        """
        self.img.save(name)


if __name__ == "__main__":
    path = r"Z:\Backup\_tmp\_img\prints_sumerx_nexus10\home.png"
    file = os.path.split(path)[1]
    extensao = os.path.splitext(file)[1]

    img = Imagem(path, extensao)
    img.redim_all_w(1080)
