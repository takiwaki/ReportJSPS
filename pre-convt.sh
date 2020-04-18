#!/bin/bash -x

##############################################################################
#
# Presentation Archive Converter
# 
# This script make CSV file for presentation to be submitted to JSPS
#             from CSV file that has informations of that.
#
#
##############################################################################

# Name of input file
csvinput=prefile.csv

# Name of output file
csvotput=presentations.csv

# separator of CSV file
sep1=","
sep2=","

export LANG=C

echo "data is read from", ${csvinput}
nkf -Lw -s --overwrite ${csvinput}

#nkf -Lu -w ${csvinput}  | wak '1' >  ${csvinput}

tail -n +2  ${csvinput} > input_tmp
file_endchar=`tail -c 1 input_tmp | xxd -p`
if [ ${file_endchar} != "0a" ]; then
    echo "add newline at the end of file"
    echo "" >> input_tmp
fi


# count the nubber of the line 
declare -i LINE
LINE=`cat input_tmp | wc -l `
echo "The file, ${csvinput}, contains ${LINE} of data."

echo "data is saved in", ${csvotput}

# initialize the file
cat /dev/null > ${csvotput}

declare -i count=1
for (( count=1; count <= $LINE ; count++)); do 
    # the 1st column corresponds doi in ${csvinput}.
    head -n ${count} input_tmp | tail -1  > line_tmp2
    sed 's/,,/, ,/g' line_tmp2 > line_tmp
     PRESENTOR=`gawk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $1 }' line_tmp `	
         TITLE=`gawk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $2 }' line_tmp `
    CONFERENCE=`gawk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $3 }' line_tmp `
      YEARFROM=`gawk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $4 }' line_tmp `
        YEARTO=`gawk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $5 }' line_tmp `
       INVITED=`gawk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $6 }' line_tmp `
       INTENAT=`gawk -v FPAT='([^,]+)|(\"[^\"]+\")' '{print $7 }' line_tmp `
       
#     echo $PRESENTOR
#     echo $TITLE
#     echo $CONFERENCE
#     echo YEARFR$YEARFROM
#     echo YEARTO$YEARTO
#     echo INVITED$INVITED
#      echo INTERNAT$INTENAT
     
    YEARTO=`echo ${YEARTO} | sed -e "s/ //g" `
      
    INVITED=`echo ${INVITED} | sed -e "s/ //g" `
#    echo INVITED $INVITED
    case ${INVITED} in
	"" | "Y" | "y" | "yes" | "Yes" | "YES" ) INVITED="1";;
	"" | "N" | "n" | "no"  | "No"  | "NO"  ) INVITED="0";;
	* ) INVITED="0";;
    esac

#    echo INVITED $INVITED
#    echo
       
    INTENAT=`echo "${INTENAT}" | sed -e "s/ //g" `
#    echo INTENAT ${INTENAT}
    case ${INTENAT} in
	"" | "Y" | "y" | "yes" | "Yes" | "YES" ) INNUM="1";;
	"" | "N" | "n" | "no"  | "No"  | "NO"  ) INNUM="0";;
	"" ) INNUM="0";;
    esac
#    echo INTENAT ${INNUM}
#    echo 
    
    echo    ${PRESENTOR}${sep2}${TITLE}${sep2}${CONFERENCE}${sep2}${YEARFROM}${sep2}${YEARTO}${sep2}${INVITED}${sep2}${INNUM} >> ${csvotput}
done
#nkf -Lw -s --overwrite ${csvotput}

rm -fr input_tmp line_tmp line_tmp2 inf_tmp

##############################################################################
#
# Written by
#   Tomoya Takiwaki ver 1.0 
# Supponsored by
#   NEW INNOVARIVE AREA, Gravitational wave physics and astronomy: Genesis
#
##############################################################################

