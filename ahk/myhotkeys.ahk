#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
; Senhas
; Senha 1313
^!Numpad1::
Send, futura{Enter}1313{Enter}
Return
; Senha 131313
^!Numpad0::
Send, futura{Enter}131313{Enter}
Return
; Senha allkeypro
^!Numpad9::
Send, administrador{Enter}allkeypro{Enter}
Return
; Aplicativos
; FuturaServer Trunk
LButton & s::
Run, "C:\_Fontes\trunk\Empresa\00000 - Generico\_EXE\FuturaServer.exe"
Return
; Gerenciador Fake
LButton & g::
Run, "C:\_Fontes\trunk\Empresa\00001 - Futura\_EXE\GerenciadorInterno.exe"
Return