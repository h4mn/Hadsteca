import ctypes
from rich.console import Console
from delphi_manager import DelphiManagerProcess

# Carregar a biblioteca kernel32.dll
kernel32 = ctypes.windll.kernel32
dmp = DelphiManagerProcess()
cn = Console()

# Obter o handle do processo do Delphi
# delphi_handle = kernel32.OpenProcess(0x1F0FFF, False, 0x1C84)
pid = dmp.get_process_id()
cn.log(pid)
delphi_handle = kernel32.OpenProcess(0x10, False, pid)

# Definir o endereço base na memória do processo
base_address = 0x00400000

