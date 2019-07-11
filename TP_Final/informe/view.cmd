@ECHO OFF


REM Muestra el informe compilado


ECHO.
ECHO.
ECHO VERSION PARA LAS POBRES ALMAS CONDENADAS A WINDOWS!!!, :).
REM Diego Luna
ECHO.
ECHO.



IF NOT [%1]==[] (
ECHO.
ECHO Error: No arguments expected.
ECHO.
REM PAUSE
EXIT 1
)



SET informname=TP_Final_Informe
SET targetdir=.\..\informe-compilado






REM #*****************************************************

SET informpdf=%informname%.pdf
SET informpdfmoved=%targetdir%\%informpdf%

SET opencmd=START "EXEC" /B
REM #******************************************************

REM #******************************************************
SET DONE=Done.


SET OPENNINGTARGETFILE=Openning file: "%informpdfmoved%"...


SET ERRORTARGETNOTEXISTS=Error file not found: "%informpdfmoved%".
SET ERROROPENNINGTARGET=Error openning the file: "%informpdfmoved%".


REM #******************************************************



IF NOT EXIST "%informpdfmoved%" (
ECHO.
ECHO %ERRORTARGETNOTEXISTS%
ECHO.
REM PAUSE
EXIT 100
)


ECHO %OPENNINGTARGETFILE%
%opencmd% >nul 2>&1 "%informpdfmoved%"

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERROROPENNINGTARGET%
ECHO.
REM PAUSE
EXIT 101
) ELSE (
ECHO %DONE%
ECHO.
REM PAUSE
EXIT 0
)







