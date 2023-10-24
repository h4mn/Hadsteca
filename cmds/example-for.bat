@SET VAR=
@CD\
@CLS
:Loop
@ECHO.
@ECHO This is the exact FOR loop we're going to run:
@ECHO ==============================================
::@TYPE "%~f0" | FIND "(" | FIND /V "FIND"
@TYPE "%~f0" | FIND "@" | FIND "." | FIND "|"
@ECHO ==============================================
@ECHO Note how the FOR command on the prompt changes with each iteration:
SET VAR
FOR %%A IN (1 2 3) DO SET VAR=%VAR%%%A
SET VAR
@ECHO.
@PAUSE
@GOTO Loop