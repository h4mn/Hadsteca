import os
import glob
from PIL import Image

class AppImg:
  def __init__(self, imgPath, device):
    self.file_name = imgPath
    self.img_input = Image.open(self.file_name)
    self.new_width, self.new_height = self.devices(device)

  def redimensionar(self, new_width, new_height):
    self.img_output = self.img_input.resize((new_width, new_height))    

  def salvar(self):
    self.redimensionar(self.new_width, self.new_height)
    filename, file_extension = os.path.splitext(self.file_name)
    self.img_output.save(f"{filename}_{self.new_width}x{self.new_height}{file_extension}")

  def devices(self, index):
    devices = {
      "iPhone_6_7in": (1290, 2796),
      "iPhone_6_5in": (1284, 2778),
      "iPhone_5_5in": (1242, 2208),
      "iPad_Pro_6th_gen_12_9in": (2732, 2048),
      "iPad_Pro_2nd_gen_12_9in": (2732, 2048),
      "Nexus_10in": (1600, 2560),
    }
    return devices[index]


def main():
  # folder_path = r"B:\_hads\_ios\7446 - Papelaria Capricho\iPhone11.images"
  folder_path = r"Z:\Backup\_tmp\_py\my_cmds\source\imagens"
  file_pattern = os.path.join(folder_path, "*.png")

  for file_name in glob.glob(file_pattern):
      img = AppImg(file_name, 'Nexus_10in')
      img.salvar()    

if __name__ == "__main__":
  main()