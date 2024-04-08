import os
import sys
import pyperclip

diretorio_atual = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(diretorio_atual, ".."))

from src.delphi_manager import DelphiManagerPath
from src.delphi_manager import DelphiManager
from src.delphi_manager import DelphiArquitetura

delphi = DelphiManager()
manager = DelphiManagerPath()
manager64 = DelphiManagerPath(DelphiArquitetura.WIN64)
LIBRARY_PATY = "Search Path"

def test_fecha_delphi():
    if delphi.is_running():
        assert delphi.close()

def test_get_library_path(arquitetura=DelphiArquitetura.WIN32):
    _manager = DelphiManagerPath(arquitetura)
    paths = _manager.get_library_path(LIBRARY_PATY).split(";")
    print(f"Valor da chave {LIBRARY_PATY}:")
    all_paths = ""
    for path in paths:
        all_paths += path + "\n"
        print(path)
    pyperclip.copy(all_paths)

def test_set_library_path():
    path = r"C:\Users\hadst\Documents\Embarcadero\Studio\18.0\CatalogRepository\TMS Software\TMS Component Pack\Win32"
    assert manager.set_library_path(LIBRARY_PATY, path)

def test_inserir_jedi_path():
    path = r"C:\Componentes\Acbr\Fontes\Terceiros\JediWin32API"
    assert manager.set_library_path(LIBRARY_PATY, path)

def test_inserir_fmxui_path():
    path = r"C:\Componentes\FMXUI\source"
    assert manager.set_library_path(LIBRARY_PATY, path)

def test_inserir_fmxui_path64():
    path = r"C:\Componentes\FMXUI\source"
    assert manager64.set_library_path(LIBRARY_PATY, path)


def main():
    # test_inserir_jedi_path()
    # test_inserir_fmxui_path()
    
    # test_inserir_fmxui_path64()
    test_get_library_path(DelphiArquitetura.WIN64)

    # test_fecha_delphi()


if __name__ == "__main__":
    main()
