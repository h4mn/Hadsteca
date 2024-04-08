""" Script para gerenciar tarefas repetitivas como manipulação do caminho das bibliotecas do Delphi no registro do Windows.
    Autor: Hadston Nunes
    Versão: 1.0
    Data: 2023.08.02
"""
import winreg
import psutil
import os

class DelphiArquitetura:
    """ Classe para gerenciar a arquitetura do Delphi.
    """
    WIN32 = "Win32"
    WIN64 = "Win64"

class DelphiManager:
    """ Classe para gerenciar o Delphi.
        Todo: Implementar abrir o Delphi.
    """
    def __init__(self):
        self.process_name = "bds.exe"
    
    def is_running(self):
        for proc in psutil.process_iter(['pid', 'name']):
            if self.process_name in proc.info['name'].lower():
                return True
        return False

    def close(self):
        for proc in psutil.process_iter(['pid', 'name']):
            if self.process_name in proc.info['name'].lower():
                try:
                    os.kill(proc.info['pid'], 9)
                    return True
                except psutil.NoSuchProcess:
                    return False
        return False


class DelphiManagerPath:
    """ Classe para gerenciar o caminho das bibliotecas do Delphi no registro do Windows.
        Todo: 
            - Implementar verificação se o caminho já existe na cadeia.
            - Implementar apagar o caminho da cadeia.
    """
    def __init__(self, arquitetura=DelphiArquitetura.WIN32):
        self.key_path = r"Software\Embarcadero\BDS\18.0\Library\{}".format(arquitetura)

    def get_library_path(self, chain_name="Browsing Path"):
        try:
            with winreg.OpenKey(winreg.HKEY_CURRENT_USER, self.key_path) as key:
                value, _ = winreg.QueryValueEx(key, chain_name)
                return value
        except FileNotFoundError:
            print("Chave do registro não encontrada.")
            return None
        except Exception as e:
            print(f"Erro ao acessar o registro: {e}")
            return None

    def set_library_path(self, chain_name, path):
        try:
            new_path = ';'.join([self.get_library_path(chain_name), path])
            with winreg.OpenKey(winreg.HKEY_CURRENT_USER, self.key_path, 0, winreg.KEY_WRITE) as key:
                winreg.SetValueEx(key, chain_name, 0, winreg.REG_SZ, new_path)
                return True
        except FileNotFoundError:
            print("Chave do registro não encontrada.")
            return False
        except Exception as e:
            print(f"Erro ao acessar o registro: {e}")
            return False


class DelphiManagerProcess:
    """ Classe para gerenciar o processo do Delphi.
    """
    def __init__(self):
        self.process_name = "bds.exe"
        self.process_id = None

    def get_process_id(self):
        for proc in psutil.process_iter(['pid', 'name']):
            if self.process_name in proc.info['name'].lower():
                return proc.info['pid']
        return None

    def get_process_handle(self):
        for proc in psutil.process_iter(['pid', 'name']):
            if self.process_name in proc.info['name'].lower():
                return proc
        return None

    def is_running(self):
        for proc in psutil.process_iter(['pid', 'name']):
            if self.process_name in proc.info['name'].lower():
                return True
        return False

    def close(self):
        for proc in psutil.process_iter(['pid', 'name']):
            if self.process_name in proc.info['name'].lower():
                try:
                    os.kill(proc.info['pid'], 9)
                    return True
                except psutil.NoSuchProcess:
                    return False
                    
