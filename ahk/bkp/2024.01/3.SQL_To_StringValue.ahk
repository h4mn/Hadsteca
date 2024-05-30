#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Insere N Quebras de linha identadas
^!Numpad3::
{
	Send '{End}'{Down}{Home}
	Loop 51 { 
		Send {+} {#}13 {+} '{Tab}{End}'{Down}{Home}
	}
	Send {Up}{End}`;
}
^!Numpad4::
{
	; MsgBox Segunda tecla executada
	; Não funcionou :(
}