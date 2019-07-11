@ECHO OFF


REM Compila el informe, chequea por errores, mueve el archivo resultante y finalmente lo muestra.
REM Usa el compilador de latex instalado y este debe estar en una ruta incluida en PATH (MikTEX la agrega).

ECHO.
ECHO.
ECHO VERSION PARA LAS POBRES ALMAS CONDENADAS A WINDOWS!!!, :).
REM Diego Luna
ECHO.
ECHO.


REM #-----------------------------------------------------

SET cmdlnERROR=false

SET cmdlnshowlog=true
SET cmdlnusepause=true


REM ---- 1 PAR -----------
IF NOT [%1]==[] (

call:MyCmdLnProc "%1"

) ELSE (
GOTO :NOMORECMDLINE
)

IF %cmdlnERROR%==true (
ECHO.
ECHO "Error: Invalid argument (argument '%1')."
ECHO.
EXIT 1
)

REM ----------------------


REM ---- 2 PAR -----------
IF NOT [%2]==[] (

call:MyCmdLnProc "%2"

) ELSE (
GOTO :NOMORECMDLINE
)

IF %cmdlnERROR%==true (
ECHO.
ECHO "Error: Invalid argument (argument '%2')."
ECHO.
EXIT 1
)

REM ----------------------


IF NOT [%3]==[] (
ECHO.
ECHO "Error: Too many arguments."
ECHO.
EXIT 1
)


:NOMORECMDLINE

REM #-----------------------------------------------------


REM #*****************************************************
SET informname=TP_Final_Informe
SET targetdir=.\..\informe-compilado
SET premises=

SET delintermediate=true
SET dellogfile=false
SET showlogfileonerror=%cmdlnshowlog%
SET showprogress=false
SET usepause=%cmdlnusepause%


REM #*****************************************************
SET informtex=%informname%.tex
SET informaux=%informname%.aux
SET informpdf=%informname%.pdf
SET informlog=%informname%.log
SET informpdfmoved=%targetdir%\%informpdf%
SET premisesmoved=%targetdir%\%premises%

SET informcmd=move

SET latexcmd=pdflatex
SET bibcmd=bibtex

SET opencmd=START "EXEC" /B

SET killcmd=taskkill /fi "WindowTitle eq %informpdf% - Adobe Acrobat Pro"
REM #******************************************************

REM #******************************************************
SET DONE=Done.

SET PRESSANYKEY=Press any key to continue...
SET COMPILING=Compiling...
SET FIRSTLATEXPASS=Running "%latexcmd%" first pass...
SET SECONDLATEXPASS=Running "%latexcmd%" second pass...
SET BIBPASS=Running "%bibcmd%"...
SET OPENNINGTARGETFILE=Openning file: "%informpdfmoved%"...
SET OPENNINGLOGFILE=Oppening file: "%informlog%"... 


SET ERRORCOMPILINGLATEX=Error compiling latex source: "%informtex%".
SET ERRORCOMPILINGLATEXAUX=Error compiling suxiliar latex source: "%informaux%".
SET ERRORGENERATINGPDF=Error generating pdf.
SET ERRORCREATINGTARGETDIR=Error creating directory: "%targetdir%".
SET ERRORKILLINGTARGET=Error killing target: "%informpdf% - Adobe Acrobat Pro".
SET ERRORMOVINGTARGET=Error copying\moving the file: "%informpdf%".
SET ERRORCOPYINGEPREM=Error copying the file: "%premisesmoved%".
SET ERROROPENNINGTARGET=Error openning the file: "%informpdfmoved%".
SET ERROROPENNINGLOG=Error openning the file: "%informlog%".
SET ERRORLATEXNOTINSTALED=Error "%latexcmd%" not installed.

REM #******************************************************


WHERE  >nul 2>&1 %latexcmd%

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORLATEXNOTINSTALED%
ECHO.
call:MyPauseFuncion 
EXIT 2
)


%killcmd% >nul 2>&1

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORKILLINGTARGET%
ECHO.
call:MyPauseFuncion 
EXIT 3

) ELSE (

call:MyWaitProc 1000

)



REM ################################################################################


IF %showprogress%==false (
ECHO.
ECHO %COMPILING%
ECHO.
)




ECHO.
ECHO %FIRSTLATEXPASS%

IF %showprogress%==true (-
"%latexcmd%" -interaction=nonstopmode --shell-escape --enable-write18 -synctex=1 "%informtex%"

) ELSE (
"%latexcmd%" >nul 2>&1 -interaction=nonstopmode --shell-escape --enable-write18 -synctex=1 "%informtex%"
)

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORCOMPILINGLATEX%
ECHO.
call:MyErrorFunction
call:MyPauseFuncion 
EXIT 100
) ELSE (
ECHO %DONE%
ECHO.
)


REM ECHO.
REM ECHO %BIBPASS%
REM 
REM IF %showprogress%==true (
REM "%bibcmd%" "%informaux%"
REM 
REM ) ELSE (
REM "%bibcmd%" >nul 2>&1 "%informaux%"
REM )
REM 
REM ECHO %DONE%
REM ECHO.


ECHO.
ECHO %SECONDLATEXPASS%

IF %showprogress%==true (
"%latexcmd%" -interaction=nonstopmode --shell-escape --enable-write18 -synctex=1 "%informtex%"

) ELSE (
"%latexcmd%" >nul 2>&1 -interaction=nonstopmode --shell-escape --enable-write18 -synctex=1 "%informtex%"
)

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORCOMPILINGLATEX%
ECHO.
call:MyErrorFunction
call:MyPauseFuncion 
EXIT 102
) ELSE (
ECHO %DONE%
ECHO.
)


REM ################################################################################



IF %delintermediate%==true (
DEL >nul 2>&1 *.aux *.bbl *.blg *.out *.toc *.dvi *.synctex.gz *.table *.gnuplot *.lof *.lot
IF %dellogfile%==true (
DEL >nul 2>&1 *.log
)
)


IF NOT EXIST "%informpdf%" (
ECHO.
ECHO %ERRORGENERATINGPDF%
ECHO.
call:MyPauseFuncion 
EXIT 103
)


IF NOT EXIST "%targetdir%\" (
MKDIR  >nul 2>&1 "%targetdir%"
IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORCREATINGTARGETDIR%
ECHO.
call:MyPauseFuncion 
EXIT 104
)
)


%killcmd% >nul 2>&1

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORKILLINGTARGET%
ECHO.
call:MyPauseFuncion 
REM EXIT 105

) ELSE (

call:MyWaitProc 1000

)


%informcmd% >nul 2>&1 "%informpdf%" "%targetdir%\"

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORMOVINGTARGET%
ECHO.
call:MyPauseFuncion 
EXIT 106
)


IF EXIST "%premises%" (
COPY >nul 2>&1 "%premises%" "%targetdir%\"

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERRORCOPYINGEPREM%
ECHO.
call:MyPauseFuncion 
EXIT 107
)
)


ECHO %OPENNINGTARGETFILE%
%opencmd% >nul 2>&1 "%informpdfmoved%"

IF ERRORLEVEL 1 (
ECHO.
ECHO %ERROROPENNINGTARGET%
ECHO.
call:MyPauseFuncion 
EXIT 108
) ELSE (
ECHO %DONE%
ECHO.
REM call:MyPauseFuncion 
EXIT 0
)



REM --------------------------
:MyErrorFunction 

IF %showlogfileonerror%==true (
%opencmd% >nul 2>&1 "%informlog%"
)
  
GOTO :EOF
REM --------------------------


REM --------------------------
:MyPauseFuncion 

IF %usepause%==true (
PAUSE
)

GOTO :EOF
REM --------------------------


REM --------------------------
:MyCmdLnProc 

IF [%~1]==[-nolog] (
SET cmdlnshowlog=false
GOTO :MyCmdLnProcEND
)


IF [%~1]==[-nopause] (
SET cmdlnusepause=false
GOTO :MyCmdLnProcEND
)



SET cmdlnERROR=true

:MyCmdLnProcEND
GOTO :EOF
REM --------------------------


REM --------------------------
:MyWaitProc 

PING 1.1.1.1 -n 1 -w %~1 >nul 2>&1

GOTO :EOF
REM --------------------------




