::CABECALHO
::---------
@echo off
@cls
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
@chcp 1252 >nul
::VARIAVEIS
::---------
rem Ambiente
::==================================================
@set PATH_WORKSPACE=C:\_tmp\_fontes
::==================================================
rem Cria um atalho relativo para o path passado no parametro baseado no segundo parametro
set "VAR_TAB=    "
rem Mensagens
set MSG_TITLE=Gerar Atalho Relativo
set MSG_AMBIENTE=Este script não pode ser executado fora do ambiente
set MSG_INICIAL=Declaração da Unit:
set MSG_SAIDA=Path copiado...
set MSG_INPUT=
set MGS_ERRORDEFAULT=Não foi possível gerar o Atalho Relativo
set MSG_ERROCAMINHO=Caminho não existe
rem Main
set "PASSOS="
set "UNIT_FILE="
set "UNIT_NAME="
set "UNIT_EXT="
set "RELATIVE_PATH="
set "SPECIFIC_PATH="
set "FINAL_PATH="
set "UNIT_DECLARATION="


title %MSG_TITLE%
@echo %MSG_INICIAL%
::MAIN
	set _FILE=%1
	set _FILE_DRIVE=%~d2
    set _DPR=%2
	set _DPR_DRIVE=%~d2

	:: Verificar e remover aspas do path _FILE e _DPR
	if "!_FILE:~1,2!" == "!_FILE_DRIVE!" (
		set "_FILE=!_FILE:~1,-1!"
	)
	if "!_DPR:~1,2!" == "!_DPR_DRIVE!" (
		set "_DPR=!_DPR:~1,-1!"
	)
	@echo %VAR_TAB%!_FILE!
	@echo.
	
	:: Adicionar cada pasta do path _DPR a uma variavel
	for /f "tokens=1,2,3,4,5,6,7,8,9,10,11 delims=\" %%a in ("!_DPR!") do (
		set "_parte1=%%a"
		set "_parte2=%%b"
		set "_parte3=%%c"
		set "_parte4=%%d"
		set "_parte5=%%e"
		set "_parte6=%%f"
		set "_parte7=%%g"
		set "_parte8=%%h"
		set "_parte9=%%i"
		set "_parte10=%%j"
		set "_parte11=%%k"
		:: Lógica para pegar as 4 ultimas partes que são diferentes de "\vazio"
		if "!_parte11!" NEQ "" (
			set "PASSOS=7"
			set "_todas=!_parte8!\!_parte9!\!_parte10!\!_parte11!"
		) else (
			if "!_parte10!" NEQ "" (
				set "PASSOS=6"
				set "_todas=!_parte7!\!_parte8!\!_parte9!\!_parte10!"
			) else (
				if "!_parte9!" NEQ "" (
					set "PASSOS=5"
					set "_todas=!_parte6!\!_parte7!\!_parte8!\!_parte9!"
				) else (
					if "!_parte8!" NEQ "" (
						set "PASSOS=4"
						set "_todas=!_parte5!\!_parte6!\!_parte7!\!_parte8!"
					) else (
						if "!_parte7!" NEQ "" (
							set "PASSOS=3"
							set "_todas=!_parte4!\!_parte5!\!_parte6!\!_parte7!"
						) else (
							if "!_parte7!" NEQ "" (
								set "PASSOS=2"
								set "_todas=!_parte3!\!_parte4!\!_parte5!\!_parte6!"
							)
						)
					)
				)
			)
		)
	)

	:: Subtrair -1 do passos
	set /a "PASSOS-=1"

	:: Laço para concatenar "..\" em cada passo
	for /l %%i in (1,1,!PASSOS!) do (
		set "RELATIVE_PATH=!RELATIVE_PATH!..\
	)

	:: Adicionar cada pasta do path _FILE a uma variavel
	for /f "tokens=1,2,3,4,5,6,7,8,9,10,11 delims=\" %%a in ("!_FILE!") do (
		set "_parte1=%%a"
		set "_parte2=%%b"
		set "_parte3=%%c"
		set "_parte4=%%d"
		set "_parte5=%%e"
		set "_parte6=%%f"
		set "_parte7=%%g"
		set "_parte8=%%h"
		set "_parte9=%%i"
		set "_parte10=%%j"
		set "_parte11=%%k"
		:: Lógica para pegar as 4 ultimas partes que são diferentes de "\vazio"
		if "!_parte11!" NEQ "" (
			set "UNIT_FILE=!_parte11!"
			set "TOTAL_PASSOS=11"
			set "PASSOS=7"
			set "_todas=!_parte8!\!_parte9!\!_parte10!\!_parte11!"
		) else (
			if "!_parte10!" NEQ "" (
				set "UNIT_FILE=!_parte10!"
				set "TOTAL_PASSOS=10"
				set "PASSOS=6"
				set "_todas=!_parte7!\!_parte8!\!_parte9!\!_parte10!"
			) else (
				if "!_parte9!" NEQ "" (
					set "UNIT_FILE=!_parte9!"
					set "TOTAL_PASSOS=9"
					set "PASSOS=5"
					set "_todas=!_parte6!\!_parte7!\!_parte8!\!_parte9!"
				) else (
					if "!_parte8!" NEQ "" (
						set "UNIT_FILE=!_parte8!"
						set "TOTAL_PASSOS=8"
						set "PASSOS=4"
						set "_todas=!_parte5!\!_parte6!\!_parte7!\!_parte8!"
					) else (
						if "!_parte7!" NEQ "" (
							set "UNIT_FILE=!_parte7!"
							set "TOTAL_PASSOS=7"
							set "PASSOS=3"
							set "_todas=!_parte4!\!_parte5!\!_parte6!\!_parte7!"
						) else (
							if "!_parte6!" NEQ "" (
								set "UNIT_FILE=!_parte6!"
								set "TOTAL_PASSOS=6"
								set "PASSOS=2"
								set "_todas=!_parte3!\!_parte4!\!_parte5!\!_parte6!"
							)
						)
					)
				)
			)
		)
	)

	:: Subtrair -1 do passos
	set /a "PASSOS-=1"

	:: Concatenar as partes do path _FILE a partir do !PASSOS!
	for /l %%i in (!PASSOS!,1,!TOTAL_PASSOS!) do (
		set "SPECIFIC_PATH=!SPECIFIC_PATH!\!_parte%%i!"
	)

	:: Verifica e retira a primeira barra do SPECIFIC_PATH
	if "!SPECIFIC_PATH:~0,1!" == "\" (
		set "SPECIFIC_PATH=!SPECIFIC_PATH:~1!"
	)

	:: Concatena o !RELATIVE_PATH! com o !SPECIFIC_PATH!
	set "FINAL_PATH=!RELATIVE_PATH!!SPECIFIC_PATH!"

	:: Retira a extensão do nome do arquivo
	set "UNIT_NAME=!UNIT_FILE:~0,-4!"

	:: Pega a extensão do arquivo
	set "UNIT_EXT=!_FILE:~-4!"

	
	:: Concatena o !UNIT_NAME! com o !FINAL_PATH! formando o UNIT_DECLARATION
	set "UNIT_DECLARATION=!UNIT_NAME! in '!FINAL_PATH!'"


	:: Verifica se a extensão é .pas ou .dfm
	if "!UNIT_EXT!" == ".pas" (
		goto:gerar
	) else (
		set "MSG_ERRO=O arquivo (!UNIT_FILE!) não é uma UNIT"
		goto:error
	)
	if "!UNIT_EXT!" == ".dfm" (
		goto:gerar
	) else (
		set "MSG_ERRO=O arquivo (!UNIT_FILE!) não é uma UNIT"
		goto:error
	)
	goto:end

:GERAR
	@REM @echo %VAR_TAB%!RELATIVE_PATH!
	@REM @echo %VAR_TAB%!_FILE!
	@REM @echo %VAR_TAB%!SPECIFIC_PATH!
	@REM @echo %VAR_TAB%!FINAL_PATH!
	@REM @echo %VAR_TAB%!UNIT_NAME!

	:: Mostra o UNIT_DECLARATION
	@echo %VAR_TAB%!UNIT_DECLARATION!

	:: Copia o UNIT_DECLARATION para o clipboard
	@echo !UNIT_DECLARATION! |clip

	:: Executa o UNIT_ADDER que insere o UNIT_DECLARATION no arquivo _DPR
	set PYTHON_PATH=C:\_tmp\_apps\Python\Python311\python.exe
	
	@REM @echo.
	@REM @echo !PYTHON_PATH! C:\_tmp\_fontes\_hads\hadsteca\experimentos\delphi\src\delphi_dpr.py "!_DPR!" "!UNIT_DECLARATION!"
	@REM @echo.
	@REM @echo.
	pushd C:\_tmp\_fontes\_hads\hadsteca\experimentos\delphi\src\
	!PYTHON_PATH! C:\_tmp\_fontes\_hads\hadsteca\experimentos\delphi\src\delphi_dpr.py "!_DPR!" "!UNIT_DECLARATION!"
	popd

	@echo.
	goto:exit

::SAIDAS
:EXIT
@echo %MSG_SAIDA% &pause>nul
goto:end

:ERROR
@echo.&echo %MGS_ERRORDEFAULT%.&echo ERROR %ERRORLEVEL%: %MSG_ERRO%!&pause>nul&goto:END
goto:end

:END