@echo off
cls
chcp 1252 >nul

setlocal EnableExtensions
setlocal EnableDelayedExpansion

:: Caminho do programa VMware
set path_exe="C:\Program Files (x86)\VMware\VMware Player\vmplayer.exe"

:: Caminho da imagem VMware
set path_vm="Z:\VM\HD\Berlin 10.4 - DEV201810.vmx"

:: Tempo de espera para carregamento do sistema
ping -n 30 127.0.0.1

:: Main
echo "Iniciando VM..."
%path_exe% %path_vm%

exit(10)