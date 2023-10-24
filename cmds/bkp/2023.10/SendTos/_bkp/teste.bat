@echo off
setlocal EnableExtensions
	call:getYear
goto:eof

:getYear
for /f " tokens=2-4 delims=-./ " %%d in ( "%date%" ) do (
	if %%d gtr 31 (
		set "_year=%%d"
	) else (
		if %%e gtr 31 (
			set "_year=%%e"
		) else (
			if %%f gtr 31 (
				set "_year=%%f"
			)
		)
	)
)
goto:eof

echo Ano: "%_year%"
pause