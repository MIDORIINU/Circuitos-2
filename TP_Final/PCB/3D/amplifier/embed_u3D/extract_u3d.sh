#!/bin/bash

set -E
set -o functrace
set -o pipefail


PDFTKPATH="C:\Program Files (x86)\HDD\Progs\x86\PDFtk\bin"
PROCFILENAME="../amplifier.pdf"
OUTPUTFILENAME="./amplifier.u3d"


if [ ! -f ${PROCFILENAME} ] ; then
       echo "File not found."
       false
fi

case "$(uname -s)" in
    MSYS*|MINGW*)             
        machine=MSYS
        ;;

    Linux*)     
        machine=Linux
        ;;

    *)
        echo -e "${RED}Platform not supported.${NC}"
        false
        ;;

esac

case "${machine}" in
    Linux) 

        ;;            

    MSYS)             
        PATH=${PATH}:$(cygpath "${PDFTKPATH}")
        ;;

esac



PROCONLYFILENAME="${PROCFILENAME%.*}"

PROCONLYFILEEXT="${PROCFILENAME##*.}"

PROCFILENAMEUNC="${PROCONLYFILENAME}.unc.${PROCONLYFILEEXT}"



pdftk "${PROCFILENAME}" output "${PROCFILENAMEUNC}" uncompress


byteranges=$( grep -obUaP $( echo -n "stream" | hexdump -e '/1 "\\"' -e '/1 "x"' -e '/1 "%02x"' ) "${PROCFILENAMEUNC}" | tail -n 2 | tr '\n' '-' )

streamstr="stream"
endstreamstr="endstream"


startrange=$( echo ${byteranges} | cut -d '-' -f1 | cut -d ':' -f 1 )

startrange=$((startrange+${#streamstr}+1))

endrange=$( echo ${byteranges} | cut -d '-' -f2 | cut -d ':' -f 1 )

endrange=$((endrange-${#endstreamstr}+${#streamstr}-2))

bytecount=$((${endrange}-${startrange}+1))


##dd if="${PROCFILENAMEUNC}" of="${OUTPUTFILENAME}" ibs=1 skip=${startrange} count=${bytecount}


dd if="${PROCFILENAMEUNC}" of="${OUTPUTFILENAME}" skip=${startrange} count=${bytecount} iflag=skip_bytes,count_bytes


rm "${PROCFILENAMEUNC}"


printf "\n\n%d bytes should have been written to file \"%s\" and %d bytes were actually written.\n\n" ${bytecount} "${OUTPUTFILENAME}" $( stat --printf="%s" "${OUTPUTFILENAME}" )





