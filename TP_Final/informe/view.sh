#!/bin/bash


#Muestra el informe, chequea por errores.


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#Cambiar acá las opciones del target.

informname="TP_Final_Informe"
targetdir="./../informe-compilado"



################################################################################


if test "$1" != ""; then
	echo "Error: No arguments expected."
	echo
	exit 1;
fi


#******************************************************
informaux="$informname.aux"
informpdf="$informname.pdf"

informpdfmoved="$targetdir/$informpdf"

informcmd="mv"


#opencmd="/usr/bin/xdg-open"
opencmd="xdg-open"
#******************************************************

#******************************************************
DONE="Done."

PRESSANYKEY="Press any key to continue..."
OPENNINGTARGETFILE="Openning file: \"$informpdfmoved\"..."
ERROROPENNINGTARGET="Error openning the file: \"$informpdfmoved\"."
ERRORXDGNOTINSTALLED="Error, \"$opencmd\" not installed in the system."


#******************************************************


function pause(){
	echo
	read -p "$PRESSANYKEY"
}


which  >/dev/null 2>/dev/null "$opencmd"

if [ $? -ne 0 ] ; then
	echo
	echo "$ERRORXDGNOTINSTALLED"
	pause
	exit 100
fi


echo
echo "$OPENNINGTARGETFILE"
"$opencmd" >/dev/null 2>/dev/null "$informpdfmoved"

if [ $? -ne 0 ] ; then

	echo
	echo "$ERROROPENNINGTARGET"
#	pause
	exit 101

else

	echo "$DONE"
	echo
#	pause
	exit 0

fi

