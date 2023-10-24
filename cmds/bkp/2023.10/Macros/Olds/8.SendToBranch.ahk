#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetBatchLines, 50ms
;SetMouseDelay, 1000

^!+B::
;Run "C:\Users\berlin\AppData\Roaming\Microsoft\Windows\SendTo\Branch Anterior.lnk"
MouseClick, right
Send, {Up}{Up}{Up}{Up}{Up}{Up}{Up}{Right}{Enter}
