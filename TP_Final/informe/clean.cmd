@ECHO OFF


REM Limpia lo generado por el compilador de latex.

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
PAUSE
EXIT 1
)



SET informname=TP_Final_Informe
SET targetdir=.\..\informe-compilado
SET informpdf=%informname%.pdf



REM #*****************************************************
DEL /Q *.aux *.bbl *.blg *.log *.out *.toc *.dvi *.synctex.gz *.table *.gnuplot *.lof *.lot
DEL /Q "%informpdf%"
DEL /Q "%targetdir%\%informpdf%"
REM #******************************************************







