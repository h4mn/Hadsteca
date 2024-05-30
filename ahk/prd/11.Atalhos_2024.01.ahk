﻿;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, 100ms

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

;DELPHI TOOLS (CTRL + NUMPAD)
;==================================================
;Enviar lista de Unidades Origem da Importação (Ctrl + NUMPAD 0)
^Numpad0::
;Send DUZIA{tab}{tab}DEZ{tab}{tab}PC{tab}{tab}JOGO{tab}{tab}UNID{tab}{tab}SET{tab}{tab}PC{tab}{tab}CENTO{tab}{tab}POTE{tab}{tab}CX{tab}{tab}PACOTE{tab}{tab}CJ{tab}{tab}PARES{tab}{tab}POTE{tab}{tab}
;Send UNID{tab}{tab}PC{tab}{tab}CJ{tab}{tab}JOGO{tab}{tab}M{tab}{tab}PACOTE{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}KIT{tab}{tab}PC{tab}{tab}UNID{tab}{tab}SACO{tab}{tab}CX{tab}{tab}M{tab}{tab}ROLO{tab}{tab}PC{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}
;Send UNID{tab}{tab}PC{tab}{tab}JOGO{tab}{tab}LITRO{tab}{tab}CJ{tab}{tab}BARRA{tab}{tab}M{tab}{tab}GALAO{tab}{tab}ML{tab}{tab}M3{tab}{tab}CX{tab}{tab}BALDE{tab}{tab}ROLO{tab}{tab}KG{tab}{tab}KIT{tab}{tab}TUBO{tab}{tab}FRASCO{tab}{tab}SACO{tab}{tab}PARES{tab}{tab}FOLHA{tab}{tab}POTE{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}M2{tab}{tab}UNID{tab}{tab}LATA{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}BISNAG{tab}{tab}
;Send FRASCO{tab}{tab}PC{tab}{tab}TAMBOR{tab}{tab}LITRO{tab}{tab}CX{tab}{tab}UNID{tab}{tab}FOLHA{tab}{tab}BLOCO{tab}{tab}M{tab}{tab}ROLO{tab}{tab}M{tab}{tab}KG{tab}{tab}GALAO{tab}{tab}POTE{tab}{tab}JOGO{tab}{tab}VIDRO{tab}{tab}UNID{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}M{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}M2{tab}{tab}KIT{tab}{tab}PALETE{tab}{tab}CENTO{tab}{tab}
;Send FRASCO{tab}{tab}PC{tab}{tab}TAMBOR{tab}{tab}LITRO{tab}{tab}CX{tab}{tab}UNID{tab}{tab}FOLHA{tab}{tab}BLOCO{tab}{tab}M{tab}{tab}ROLO{tab}{tab}M{tab}{tab}GALAO{tab}{tab}POTE{tab}{tab}JOGO{tab}{tab}VIDRO{tab}{tab}UNID{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}M{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}KIT{tab}{tab}PALETE{tab}{tab}CENTO{tab}{tab}
;Send UNID{tab}{tab}UNID{tab}{tab}PC{tab}{tab}DUZIA{tab}{tab}CENTO{tab}{tab}PC{tab}{tab}UNID{tab}{tab}JOGO{tab}{tab}
;Send UNID{tab}{tab}UNID{tab}{tab}POTE{tab}{tab}PC{tab}{tab}PC{tab}{tab}EMBAL{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}CJ{tab}{tab}PACOTE{tab}{tab}
;Send saco{tab}{tab}unid{tab}{tab}FARDO{tab}{tab}
;Send UNID{tab}{tab}PC{tab}{tab}PC{tab}{tab}PARES{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}POTE{tab}{tab}FRASCO{tab}{tab}PACOTE{tab}{tab}KIT{tab}{tab}PARES{tab}{tab}PC{tab}{tab}KIT{tab}{tab}CX{tab}{tab}FARDO{tab}{tab}UNID{tab}{tab}CJ{tab}{tab}FARDO{tab}{tab}CJ{tab}{tab}PARES{tab}{tab}UNID{tab}{tab}PARES{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}BARRA{tab}{tab}UNID{tab}{tab}KG{tab}{tab}UNID{tab}{tab}FARDO{tab}{tab}BISNAG{tab}{tab}UNID{tab}{tab}PACOTE{tab}{tab}UNID{tab}{tab}
;Send UNID{tab}{tab}UNID{tab}{tab}PC{tab}{tab}POTE{tab}{tab}PACOTE{tab}{tab}CJ{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}PC{tab}{tab}UNID{tab}{tab}
;Send UNID{tab}{tab}PC{tab}{tab}PARES{tab}{tab}UNID{tab}{tab}CJ{tab}{tab}PARES{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}CX{tab}{tab}KIT{tab}{tab}UNID{tab}{tab}KIT{tab}{tab}PACOTE{tab}{tab}UNID{tab}{tab}PC{tab}{tab}PC{tab}{tab}FRASCO{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}PACOTE{tab}{tab}PACOTE{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}PARES{tab}{tab}FARDO{tab}{tab}FARDO{tab}{tab}
;Send UNID{tab}{tab}CJ{tab}{tab}PC{tab}{tab}PC{tab}{tab}POTE{tab}{tab}PARES{tab}{tab}UNID{tab}{tab}PARES{tab}{tab}KIT{tab}{tab}CX{tab}{tab}PACOTE{tab}{tab}PC{tab}{tab}UNID{tab}{tab}KIT{tab}{tab}FRASCO{tab}{tab}PARES{tab}{tab}CJ{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}PACOTE{tab}{tab}FARDO{tab}{tab}BISNAG{tab}{tab}CJ{tab}{tab}BARRA{tab}{tab}PARES{tab}{tab}UNID{tab}{tab}PC{tab}{tab}KG{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}UNID{tab}{tab}
Send UNID{tab}{tab}KG{tab}{tab}SACO{tab}{tab}PC{tab}{tab}M{tab}{tab}
return

;Copiar atalho (Ctrl + NUMPAD 1)
^Numpad1::
Send !t1
return

;Copiar atalho relativo (Ctrl + NUMPAD 2)
^Numpad2::
Send !t2
return

;Enviar para Branch (Ctrl + NUMPAD 3)
^Numpad3::
Send !t3
return


;	PREENCHE FORMULARIO 1 (Ctrl + NUMPAD 4) ****
;=============================================
^Numpad4::
;Preenche Justificativa do Cancelamento (PDV > Trocas e Devoluções)
Send TESTE DE CANCELAMENTO DEBUG %A_Now%.%A_MSec%{Tab} ;Pedido Nro/Nota Fiscal Nro
Sleep, 500
return


;Gerenciador do Delphi Layout Desktop
;=========================
;Muda para Layout abaixo (Ctrl + F6)
^F6::
Send {F6}+{tab}+{tab}+{tab}{Down}{Enter}
return
;Muda para Editor acima (CTRL + SHIFT + F6)
^+F6::
Send {F6}+{tab}+{tab}+{tab}{Up}{Enter}
return


;	PREENCHE FORMULARIO 2 (Ctrl + NUMPAD 5) ****
;=============================================
; ^Numpad5::
; ; Tarefa	: Funcionalidade de Copiar Terminal
; ; Formulário: Copiar e Inativar Cliente
; ; Caminho	: Cadastro > Cadastros > Cliente Mensalistas > Clientes - Manutenção e Revisão | Principal > Financeiro > [Inativar/Copiar/Repassar Cobrança]
; ; Base		: C:\_tmp\_bases\FUTURA.FDB (P:\9 - Outros\Hadston\Futura\ATUALIZARFUTURA.FDB)
; ; Criação	: 2024.03.11
; ; ----------------------------------------
; ; Preencher Campo 1: Justificativa p/ Inativação
; Send TESTE FINANCEIRO COPIAR COM LIMITE TERMINAL 2{Tab}
; Sleep, 300
; ; ----------------------------------------
; ; Preencher Campo 2: Novo Código
; ;CADASTRO_ID: XXXX
; ;Send 131313{Tab}{Tab}
; ;CADASTRO_ID: 11147
; Send 131314{Tab}{Tab}
; Sleep, 300
; ; ----------------------------------------
; ; Preencher Campo 2: Novo CNPJ
; ;Send 58171556000120{Tab}
; Send 94681388000187{Tab}
; Sleep, 300
; ; ----------------------------------------
; ; Preencher Campo 2: Novo IE
; ;Send 169156135997{Tab}
; Send 139077510768{Tab}
; Sleep, 300
; ; ----------------------------------------
; ; Preencher Campo 2: Nova Razao
; Send TESTE FINANCEIRO COPIAR COM LIMITE TERMINAL 2 - RAZAO{Tab}
; Sleep, 300
; ; ----------------------------------------
; ; Preencher Campo 2: Nova Fantasia
; Send TESTE FINANCEIRO COPIAR COM LIMITE TERMINAL 2 - FANTASIA{Tab}
; Sleep, 300
; ; ----------------------------------------
; ; Tabular Botão: Executar
; Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Enter}
; Sleep, 300
; return


^Numpad5::
; Tarefa		: Cadastrar Nova Contas a Receber
; Formulário	: Contas a Receber
; Caminho		: Contas a Receber > Digitação
; Base			: C:\_tmp\_bases\CHEQUES.FDB
; Multiempresa 	: True
; Criação		: 2024.05.02
; ----------------------------------------
; Setup
FormatTime, DataAmerica, %A_Now%, yyyyMMddHHmmss
FormatTime, DataEmissao, %A_Now%, ddMMyyyy
Random, Valor, 50, 200
Random, Dias, 0, 2
FormatTime, DataVencimentoA, %A_Now%, ddMMyyyy
DataVencimentoA =+ %Dias%
FormatTime, DataVencimentoB, %A_Now%, ddMMyyyy

; ----------------------------------------
; Preencher Campo 0: Novo
Send {F2}
Sleep, 500
; ----------------------------------------
; Preencher Campo 1: Empresa
Send {Tab}
Sleep, 300
; ----------------------------------------
; Preencher Campo 2: Cliente
Send 3401{Tab} ;Cliente: 3401 - CLIENTE TESTE
Sleep, 300
; ----------------------------------------
; Preencher Campo 3: Documento
Send %DataAmerica%{Tab} ;Documento: 202405021234
Sleep, 500
; ----------------------------------------
; Preencher Campo 4: Data Emissao
Send %DataEmissao%{Tab} ;Data Emissao: 02052024
Sleep, 300
; ----------------------------------------
; Preencher Campo 5: Historico
Send TESTE AUTOCAD %DataAmerica%{Tab} ;Historico: TESTE AUTOCAD 202405021234
Sleep, 300
; ----------------------------------------
; Preencher Campo 6: Prazo
Send 6{Tab} ;Prazo: 6
Sleep, 300
; ----------------------------------------
; Preencher Campo 7: Valor
Send %Valor%{Tab} ;Valor: 100
Sleep, 300
; ----------------------------------------
; Preencher Campo 8: Gerar Parcelas
Send {Enter}
Sleep, 300
Send {Enter}
Sleep, 300
Send {Enter}
Sleep, 300
Send {Enter}
Sleep, 300
; ----------------------------------------
; Preencher Campo 9: Data Vencimento
Send {Tab}{Tab}
Send %DataVencimentoB%{Tab} ;Data Vencimento: 04052024
Sleep, 300
; ----------------------------------------
; Tabular Botão: Gravar
Send {F10}
Sleep, 300
return


; ;Auto-cadastro de cliente (Ctrl + NUMPAD 5) ****
; Send {Tab}
; Send 48627302000110
; Send {Tab}
; Send 974121245371
; Send {Tab}
; Send {End}
; Send {Tab}{Tab}{Tab}{Tab}{Tab}
; Send Maya e Jéssica Mudanças ME
; Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
; Send 13406030
; Send {Tab}
; Send SP
; Send {Tab}
; return

; ;Copiar Layout Properties (Ctrl + NUMPAD 5) ****
; Clipboard := ""
; Send, {Home}
; Send, {Shift}+{End}
; Send, ^{c}
; Sleep, 500
; FileAppend, %clipboard%, F:\BACKUP\Temp\_ahk\clip_height.clip
; Send, {Down}
; ;=========================
; Clipboard := ""
; Send, {Home}
; Send, {Shift}+{End}
; Send, ^{c}
; Sleep, 500
; FileAppend, %Clipboard%, F:\BACKUP\Temp\_ahk\clip_left.clip
; Send, {Down}{Down}{Down}{Down}
; ;=========================
; Clipboard := ""
; Send, {Home}
; Send, {Shift}+{End}
; Send, ^{c}
; Sleep, 500
; FileAppend, %Clipboard%, F:\BACKUP\Temp\_ahk\clip_top.clip
; Send, {Down}
; ;=========================
; Clipboard := ""
; Send, {Home}
; Send, {Shift}+{End}
; Send, ^{c}
; Sleep, 500
; FileAppend, %Clipboard%, F:\BACKUP\Temp\_ahk\clip_width.clip
; ;=========================
; return

;Le os Layout Properties gravados (Ctrl + NUMPAD 6)
^Numpad6::
Clipboard := ""
FileRead, clipsaved, F:\BACKUP\Temp\_ahk\clip_height.clip
Sleep, 500
clipsaida := "Height: " clipsaved
FileRead, clipsaved, F:\BACKUP\Temp\_ahk\clip_left.clip
Sleep, 500
clipsaida := clipsaida "; Left: " clipsaved
FileRead, clipsaved, F:\BACKUP\Temp\_ahk\clip_top.clip
Sleep, 500
clipsaida := clipsaida "; Top: " clipsaved
FileRead, clipsaved, F:\BACKUP\Temp\_ahk\clip_width.clip
Sleep, 500
clipsaida := clipsaida "; Width: " clipsaved
FileDelete, F:\BACKUP\Temp\_ahk\clip_height.clip
FileDelete, F:\BACKUP\Temp\_ahk\clip_left.clip
FileDelete, F:\BACKUP\Temp\_ahk\clip_top.clip
FileDelete, F:\BACKUP\Temp\_ahk\clip_width.clip
;Clipboard := clipsaida
Send, %clipsaida%
return


;FERRAMENTAS DE PRODUTIVIDADE
;==================================================

;Encapsular parametro em função (Ctrl + NUMPAD 7)
^Numpad7::
Run, C:\_tmp\_apps\Python\Python311\python.exe "C:\_tmp\_fontes\_hads\hadsteca\python\strings\encapsula_param.py"
Sleep, 1000
Send, ^v
return

;Encapsular parametro em função (Ctrl + NUMPAD 7)
^Numpad8::
Run, C:\_tmp\_apps\Python\Python311\python.exe "C:\_tmp\_fontes\_hads\hadsteca\python\strings\encapsula_param.py"
Sleep, 1000
Send, ^v
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

;TESTE 131313							(CTRL + ALT + 2)
^!Numpad2::
Send LUIZMONARO{return}131313{return}
return

;FUTURA1 131313 						(CTRL + ALT + 3)
^!Numpad3::
Send futura1{return}131313{return}
return

;HADS 131313 							(CTRL + ALT + 4)
^!Numpad4::
Send hads{return}131313{return}
return

;AWS 									(CTRL + ALT + 6)
^!Numpad6::
Send y37A)U$s)RU&3EI)QHszae{!}eNyrgcaPs
return

;FUTURA ADMINISTRADOR					(CTRL + ALT + 9)
^!Numpad9::
Send ADMINISTRADOR{return}ALLKEYPRO{return}
return

;EXECUTA SCRIPTS
;==================================================

^!Numpad5::
;FAZ BACKUP DOS RTMs								(CTRL + ALT + 5)
;Run Z:\DEV\1.backup_temp_rtm.bat
;FAZ LOGIN DE CONEXÃO LOCAL DO LAYOUT DINÂMICO		(CTRL + ALT + 5)
;=============== Base Local
Send localhost/3050{return}
Send C:\_tmp\_bases\CHEQUES.FDB{return}
Send sysdba{return}
Send sbofutura{return}{return}
;=============== Base Vitão
; Send 192.168.5.89/3051{return}
; Send D:\Cliente\Dados\DADOS.FDB{return}
; Send sysdba{return}
; Send sbofutura{return}{return}
;=============== Base Jambo
; Send prog19-vm/3051{return}
; Send C:\_tmp\_bases\JAMBO.FDB{return}
; Send sysdba{return}
; Send sbofutura{return}{return}


return

;ENVIA PARA BRANCH						(CTRL + ALT + SHIFT + B)
^!+B::
;Run "C:\Users\berlin\AppData\Roaming\Microsoft\Windows\SendTo\Branch Anterior.lnk"
MouseClick, right
Send, {Up}{Up}{Up}{Up}{Up}{Up}{Up}{Right}{Down}B{Enter}

return

;COPIA ATALHO						(CTRL + ALT + SHIFT + C)
;^!+C::
;Run "C:\Users\berlin\AppData\Roaming\Microsoft\Windows\SendTo\Copia Atalho.lnk"
;MouseClick, right
;Send, {Up}{Up}{Up}{Up}{Up}{Up}{Up}{Right}{Down}C{Enter}
;return

;APLICATIVOS FUTURA
;TODO: Melhorar este sistema de atalhos. Talvez uma mini janela que abre mostrando as opções.
;==================================================
;TRANSFERE LAYOUT						(CTRL + ALT + SHIFT + T)
; ^!+T::
; Run "C:\FUTURA\Utilitários\TransfereLayoutDinamico.exe"
; return

; ;GERENCIADOR FAKE						(CTRL + ALT + SHIFT + G)
; ^!+G::
; Run "C:\_Fontes\trunk\Empresa\00001 - Futura\_EXE\GerenciadorInterno.exe"
; return

; ;HADSTECA								(LEFT MOUSE CLICK + H)
; ~LButton & H::
; Run "Z:\DEV\Delphi\HadsTeca.groupproj"
; return

; ;GENERICO								(LEFT MOUSE CLICK + S)
; ~LButton & S::
; Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupGenerico.groupproj"
; return

; ;GOURMET								(LEFT MOUSE CLICK + G)
; ~LButton & G::
; Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupGourmet.groupproj"
; return

; ;OS								(LEFT MOUSE CLICK + O)
; ~LButton & O::
; Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupFuturaOS.groupproj"
; return

; ;FUTURA									(LEFT MOUSE CLICK + F)
; ~LButton & F::
; Run "C:\_Fontes\trunk\Empresa\00001 - Futura\Sistemas\ProjectGroupFutura.groupproj"
; return

; ;NELIDA									(LEFT MOUSE CLICK + N)
; ~LButton & N::
; Run "C:\_Fontes\trunk\Empresa\00158 - Nelida\Sistemas\ProjectGroup_Nelida.groupproj"
; return

Saida:
Exit