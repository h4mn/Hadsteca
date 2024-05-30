#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Insere N Quebras de linha identadas
^!Numpad2::
Send {Enter}{Tab}
Loop 59 {
	Loop, 4 {
		Send ^{Right}
	}
	Send {Enter}
}
	