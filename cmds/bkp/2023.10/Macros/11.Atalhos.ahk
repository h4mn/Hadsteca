#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, 200ms

;EDITAR
;==================================================
;DUPLICAR LINHA
^+D::
	Send {Home}{Home}+{End}
	Send {Ctrl down}c{Ctrl up}
	Send {End}{Enter}
	Send {Ctrl down}v{Ctrl up}
	Send {End}
return

;IMPORTACAO (CTRL + NUMPAD)
;==================================================
;ENVIA LISTA DE UNIDADES ORIGEM			(CTRL + 1)
^Numpad1::
;Send DUZIA{tab}{tab}DEZ{tab}{tab}PC{tab}{tab}JOGO{tab}{tab}UNID{tab}{tab}SET{tab}{tab}PC{tab}{tab}CENTO{tab}{tab}POTE{tab}{tab}CX{tab}{tab}PACOTE{tab}{tab}CJ{tab}{tab}PARES{tab}{tab}POTE{tab}{tab}
;Send UNID{tab}{tab}PARES{tab}{tab}M{tab}{tab}UNID{tab}{tab}DUZIA{tab}{tab}CX{tab}{tab}PACOTE{tab}{tab}KG{tab}{tab}ROLO{tab}{tab}LITRO{tab}{tab}
;Send UNID{tab}{tab}M{tab}{tab}KG{tab}{tab}UNID{tab}{tab}
;Send UNID{tab}{tab}PACOTE{tab}{tab}PC{tab}{tab}ROLO{tab}{tab}LITRO{tab}{tab}KG{tab}{tab}CX{tab}{tab}UNID{tab}{tab}JOGO{tab}{tab}UNID{tab}{tab}CART{tab}{tab}POTE{tab}{tab}GALAO{tab}{tab}
;120107 - Para ser feita importação futura
;Send PC{tab}{tab}PC{tab}{tab}UNID{tab}{tab}M{tab}{tab}ROLO{tab}{tab}CART{tab}{tab}PC{tab}{tab}UNID{tab}{tab}LITRO{tab}{tab}CX{tab}{tab}PC{tab}{tab}KG{tab}{tab}PC{tab}{tab}PC{tab}{tab}UNID{tab}{tab}PC{tab}{tab}PACOTE{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}PC{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}PACOTE{tab}{tab}UNID{tab}{tab}KIT{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}
Send PC{tab}{tab}UNID{tab}{tab}KG{tab}{tab}
return

;SUBSTITUI PARTE DE UMA STRING NO CLIPBOARD PELO ENDERECO DE REDE	(CTRL + 2)
^Numpad2::
vPathLocal := % SubStr(Clipboard, 4)
Clipboard := "Importado em ""\\\192.168.1.2\basesimportacao$" . vPathLocal
return

;TEMP							(CTRL + ALT + 8)
^!Numpad8::
Send P:\Anderson\XML COMPRA\debug_35201169194454000651550560001922591002194774-nfe.xml{return}2{return}
return

;LOGINS (CTRL + ALT + NUMPAD)
;==================================================
;FUTURA 1313							(CTRL + ALT + 0)
^!Numpad0::
Send futura{return}1313{return}
return

;FUTURA 131313 							(CTRL + ALT + 1)
^!Numpad1::
Send futura{return}131313{return}
return

;FUTURA1 1313							(CTRL + ALT + 2)
^!Numpad2::
Send futura1{return}1313{return}
return

;FUTURA1 131313 							(CTRL + ALT + 3)
^!Numpad3::
Send futura1{return}131313{return}
return

;AWS 							(CTRL + ALT + 6)
^!Numpad6::
Send y37A)U$s)RU&3EI)QHszae{!}eNyrgcaPs
return

;FUTURA ADMINISTRADOR					(CTRL + ALT + 9)
^!Numpad9::
Send ADMINISTRADOR{return}ALLKEYPRO{return}
return

;EXECUTA SCRIPTS
;==================================================
;FAZ BACKUP DOS RTMs					(CTRL + ALT + 5)
^!Numpad5::
Run Z:\DEV\1.backup_temp_rtm.bat
return

;ENVIA PARA BRANCH						(CTRL + ALT + SHIFT + B)
^!+B::
;Run "C:\Users\berlin\AppData\Roaming\Microsoft\Windows\SendTo\Branch Anterior.lnk"
MouseClick, right
Send, {Up}{Up}{Up}{Up}{Up}{Up}{Up}{Right}{Down}B{Enter}
return

;COPIA ATALHO						(CTRL + ALT + SHIFT + C)
^!+C::
;Run "C:\Users\berlin\AppData\Roaming\Microsoft\Windows\SendTo\Copia Atalho.lnk"
MouseClick, right
Send, {Up}{Up}{Up}{Up}{Up}{Up}{Up}{Right}{Down}C{Enter}
return

;APLICATIVOS FUTURA
;==================================================
;TRANSFERE LAYOUT						(CTRL + ALT + SHIFT + T)
^!+T::
Run "C:\FUTURA\Utilitários\TransfereLayoutDinamico.exe"
return

;GERENCIADOR FAKE						(CTRL + ALT + SHIFT + G)
^!+G::
Run "C:\_Fontes\trunk\Empresa\00001 - Futura\_EXE\GerenciadorInterno.exe"
return

;HADSTECA								(LEFT MOUSE CLICK + H)
~LButton & H::
Run "Z:\DEV\Delphi\HadsTeca.groupproj"
return

;GENERICO								(LEFT MOUSE CLICK + S)
~LButton & S::
Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupGenerico.groupproj"
return

;GOURMET								(LEFT MOUSE CLICK + G)
~LButton & G::
Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupGourmet.groupproj"
return

;OS								(LEFT MOUSE CLICK + O)
~LButton & O::
Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupFuturaOS.groupproj"
return

;FUTURA									(LEFT MOUSE CLICK + F)
~LButton & F::
Run "C:\_Fontes\trunk\Empresa\00001 - Futura\Sistemas\ProjectGroupFutura.groupproj"
return

;NELIDA									(LEFT MOUSE CLICK + N)
~LButton & N::
Run "C:\_Fontes\trunk\Empresa\00158 - Nelida\Sistemas\ProjectGroup_Nelida.groupproj"
return