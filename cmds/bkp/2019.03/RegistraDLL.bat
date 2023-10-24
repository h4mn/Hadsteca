@ECHO OFF

if EXIST %windir%\SysWOW64\x64 goto Win64

:Win32
ECHO *** Copiando as DLLs ***
if NOT EXIST %windir%\System32\NFE_dll.dll copy NFE_dll.dll %windir%\System32
if NOT EXIST %windir%\System32\NFE_dll.tlb  copy NFE_dll.tlb  %windir%\System32
if NOT EXIST %windir%\System32\RegAsm.exe  copy RegAsm.exe  %windir%\System32
ECHO *** Registrando as DLLs ***
regasm NFE_dll.dll /tlb:NFE_dll.tlb
goto end

:Win64
ECHO *** Copiando as DLLs x64 ***
if NOT EXIST %windir%\SysWOW64\NFE_dll.dll copy NFE_dll.dll %windir%\SysWOW64
if NOT EXIST %windir%\SysWOW64\NFE_dll.tlb  copy NFE_dll.tlb  %windir%\SysWOW64
if NOT EXIST %windir%\SysWOW64\RegAsm.exe  copy RegAsm.exe  %windir%\SysWOW64
ECHO *** Registrando as DLLs x64 ***
regasm NFE_dll.dll /tlb:NFE_dll.tlb


goto end

:end


pause