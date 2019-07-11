#!/bin/bash


#Limpia todo lo generado por el compilador de Latex.


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Cambiar acá las opciones del target.

inforname="TP_Final_Informe"
destino="./../informe-compilado"


################################################################################

if test "$1" != ""; then
	echo "Error: No arguments expected."
	echo
	exit 1;
fi


informepdf="$inforname.pdf"

rm -f *.aux *.bbl *.blg *.log *.out *.toc *.dvi *.synctex.gz *.lof *.lot
rm -f "$informepdf"
#rm -f -r "$destino"

