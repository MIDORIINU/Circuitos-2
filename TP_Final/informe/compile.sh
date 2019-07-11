#!/bin/bash


#Compila el informe, chequea por errores, mueve el archivo resultante y finalmente lo muestra.


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Cambiar acá las opciones del target.

informname="TP_Final_Informe"
targetdir="./../informe-compilado"
premises=""

delintermediate=true
dellogfile=false
showprogress=false
showlogfileonerror=true

################################################################################


if test "$1" != ""; then
	echo "Error: No arguments expected."
	echo
	exit 1;
fi


#******************************************************
informtex="$informname.tex"
informaux="$informname.aux"
informpdf="$informname.pdf"
informlog="$informname.log"
informpdfmoved="$targetdir/$informpdf"
premisesmoved="$targetdir/$premises"

informcmd="mv"

latexcmd="pdflatex"
bibcmd="bibtex"

#opencmd="/usr/bin/xdg-open"
opencmd="xdg-open"
#******************************************************

#******************************************************
DONE="Done."

PRESSANYKEY="Press any key to continue..."
COMPILING="Compiling..."
FIRSTLATEXPASS="Running \"$latexcmd\" first pass..."
SECONDLATEXPASS="Running \"$latexcmd\" second pass..."
BIBPASS="Running \"$bibcmd\"..."
OPENNINGTARGETFILE="Openning file: \"$informpdfmoved\"..."
OPENNINGLOGFILE="Oppening file: \"$informlog\"..." 


ERRORCOMPILINGLATEX="Error compiling latex source: \"$informtex\"."
ERRORCOMPILINGLATEXAUX="Error compiling suxiliar latex source: \"$informaux\"."
ERRORGENERATINGPDF="Error generating pdf."
ERRORCREATINGTARGETDIR="Error creating directory: \"$targetdir\"."
ERRORMOVINGTARGET="Error copying\\moving the file: \"$informpdf\"."
ERRORCOPYINGEPREM="Error copying the file: \"$premisesmoved\"."
ERROROPENNINGTARGET="Error openning the file: \"$informpdfmoved\"."
ERRORXDGNOTINSTALLED="Error, \"$opencmd\" not installed in the system."
ERROROPENNINGLOG="Error openning the file: \"$informlog\"."
ERRORLATEXNOTINSTALED="Error, \"$latexcmd\" not installed."

#******************************************************


function pause(){
	echo
	read -p "$PRESSANYKEY"
}

function clean(){
	rm -f 2>/dev/null *.aux *.bbl *.blg *.out *.toc *.dvi *.lof *.lot

	if $dellogfile ; then
	
		rm -f 2>/dev/null *.log

	fi
}

function openlog(){

	if ! $showlogfileonerror ; then
		return
	fi

	if [ ! -f "$informlog" ] ; then
		return
	fi

	if [ ! -f "$opencmd" ] ; then
		return
	fi

	echo
	echo "$OPENNINGLOGFILE"
	"$opencmd" "$informlog" 2>/dev/null

	if [ $? -ne 0 ] ; then

		echo
		echo "$ERROROPENNINGLOG"

	else

		echo "$DONE"
		echo

	fi
}


which  >/dev/null 2>/dev/null "$latexcmd"

if [ $? -ne 0 ] ; then
	echo
	echo "$ERRORLATEXNOTINSTALED"
#	pause
	exit 2
fi

################################################################################
#Latex compile.
###############

if ! $showprogress ; then
	echo
	echo "$COMPILING"
	echo
fi


echo
echo "$FIRSTLATEXPASS"
if $showprogress ; then
	"$latexcmd" -interaction=nonstopmode -shell-escape "$informtex"
else
	"$latexcmd" -interaction=nonstopmode -shell-escape "$informtex" >/dev/null 2>/dev/null
fi

if [ $? -ne 0 ] ; then
	echo
	echo "$ERRORCOMPILINGLATEX"
	openlog
#	pause
	dellogfile=false
	clean
	exit 100
else
	echo "$DONE"
	echo
fi


echo
#echo "$BIBPASS"
#if $showprogress ; then
#	"$bibcmd" "$informaux"
#else
#	"$bibcmd" "$informaux" >/dev/null 2>/dev/null
#fi

#if [ $? -ne 0 ] ; then
#	echo
#	echo "$ERRORCOMPILINGLATEXAUX"
#	openlog)
#	pause
#	dellogfile=false
#	clean
#	exit 101
#else
#	echo "$DONE"
#	echo
#fi


echo
echo "$SECONDLATEXPASS"
if $showprogress ; then
	"$latexcmd" -interaction=nonstopmode -shell-escape "$informtex"
else
	"$latexcmd" -interaction=nonstopmode -shell-escape "$informtex" >/dev/null 2>/dev/null
fi

if [ $? -ne 0 ] ; then
	echo
	echo "$ERRORCOMPILINGLATEX"
	openlog
#	pause
	dellogfile=false
	clean
	exit 102
else
	echo "$DONE"
	echo
fi

################################################################################


if $delintermediate; then
	clean
fi


if [ ! -f "$informpdf" ] ; then

	echo
	echo "$ERRORGENERATINGPDF"
#	pause
	exit 103
fi


if [ ! -d "$targetdir" ] ; then

	mkdir "$targetdir" 2>/dev/null

	if [ $? -ne 0 ] || [ ! -d "$targetdir" ] ; then
		echo
		echo "$ERRORCREATINGTARGETDIR"
#		pause
		exit 104
	fi

fi

	
"$informcmd" "$informpdf" "$targetdir/" 2>/dev/null

if [ $? -ne 0 ] || [ ! -f "$informpdfmoved" ] ; then

	echo
	echo "$ERRORMOVINGTARGET"
#	pause
	exit 105

fi



if [ -f "$premises" ] ; then

	cp "$premises" "$targetdir" 2>/dev/null

	if [ $? -ne 0 ] || [ ! -f "$premisesmoved" ] ; then

		echo
		echo "$ERRORCOPYINGEPREM"
#		pause
		exit 106

	fi

fi



#if [ ! -f "$opencmd" ] ; then
#
#	echo
#	echo "$ERRORXDGNOTINSTALLED"
#	pause
#	exit 107
#
#fi

which  >/dev/null 2>/dev/null "$opencmd"

if [ $? -ne 0 ] ; then
	echo
	echo "$ERRORXDGNOTINSTALLED"
#	pause
	exit 107
fi


echo
echo "$OPENNINGTARGETFILE"
"$opencmd" >/dev/null 2>/dev/null "$informpdfmoved"

if [ $? -ne 0 ] ; then

	echo
	echo "$ERROROPENNINGTARGET"
#	pause
	exit 108

else

	echo "$DONE"
	echo
#	pause
	exit 0

fi

