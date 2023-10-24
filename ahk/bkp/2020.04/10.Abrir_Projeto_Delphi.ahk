#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;GENERICO
~LButton & G::
Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupGenerico.groupproj"
return


;GOURMET
~LButton & O::
Run "C:\_Fontes\trunk\Empresa\00000 - Generico\Sistemas\ProjectGroupGourmet.groupproj"
return


;FUTURA
~LButton & F::
Run "C:\_Fontes\trunk\Empresa\00001 - Futura\Sistemas\ProjectGroupFutura.groupproj"
return


;NELIDA
~LButton & N::
Run "C:\_Fontes\trunk\Empresa\00158 - Nelida\Sistemas\ProjectGroup_Nelida.groupproj"
return