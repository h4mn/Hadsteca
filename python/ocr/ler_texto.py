# cabeçalho
# Autor: Hadston Nunes
# Data: 2024-06-07
# Descrição: Este script lê o texto de uma imagem e imprime na tela

# Instalando a biblioteca pytesseract
# pip install pytesseract

# Importando a biblioteca pytesseract
import pytesseract
from PIL import Image

# Carrega a imagem
file = 'python\ocr\imagens\Screenshot_1.png'
# Verifica se o arquivo existe
try:
    img = Image.open(file)
except FileNotFoundError:
    print('Arquivo não encontrado')

# Extrai o texto da imagem
texto = pytesseract.image_to_string(img)

# Imprime o texto extraído
print("="*40)
print(texto)
print("="*40)