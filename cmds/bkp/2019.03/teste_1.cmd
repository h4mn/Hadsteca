@echo off
goto:listando_arquivos_do_diretorio_atual

:entendendo_o_for_1
set myvar=a b,c;d
for %%b in (%myvar%) do echo %%b
goto:fim

:entendendo_o_for_2
for %%i in (a b c) do call :for_body %%i
goto:fim

:for_body
    echo 1 %1
    goto :cont
    echo 2 %1
  :cont
goto:eof

:listando_arquivos_do_diretorio_atual
set /a i=0
for /f "tokens=*" %%f in ('dir /b /s *.fdb') do (
	set /a i+=1
	echo %%f
	echo %%~tf
	set DATA=%%~tf
	set MES=%DATA:~3,2%
	echo MES: %MES%
	pause
	REM set DIA=%date:~0,2%
)
echo.&echo %i% arquivos .fdb encontrados
goto:fim

:fim
echo.&echo Fim . . .&pause>nul&goto:eof