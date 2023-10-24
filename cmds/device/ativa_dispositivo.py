import win32com.client as win32

class Dispositivos:
    def __init__(self):
        self.wmi = win32.GetObject("winmgmts:")
        self.dispositivos = self.wmi.InstancesOf("Win32_PnPEntity")

    def listar(self, com_erro=True):
        for dispositivo in self.dispositivos:
            if com_erro:
                if dispositivo.Status == 'Error':
                    print('Dispositivo com erro encontrado')
                    print(f'Device ID: "{dispositivo.DeviceID}"')
                    print(f'Device Name: {dispositivo.Name}')
                    print('='*50)
            else:
                if dispositivo.Status != 'Error':
                    print(f'Device Name: {dispositivo.Name}')
                    print('='*50)


    def ativar(self, device_name):
        for dispositivo in self.dispositivos:
            if dispositivo.Name == device_name:
                try:
                    dispositivo.SetPowerState(0, 1)
                    print(f'Dispositivo "{dispositivo.DeviceID}" ativado com sucesso')
                    pass
                except Exception as e:
                    print(f'Erro ao ativar dispositivo "{dispositivo.DeviceID}"')
                    raise e
        else:
            print('Dispositivo não encontrado')


if __name__ == '__main__':
    devices = Dispositivos()
    devices.listar()
    devices.ativar('Radeon RX550/550 Series')
    devices.listar()
