#!/bin/bash -x

##############################################################################
#
# DOI converter
# 
# This script make CSV file for Journal articles to be submitted to JSPS
#             from CSV file that has DOI information.
#
# This script uses "curl". If it has not been installed,
# please install it before running this script.
#
##############################################################################

# Name of input file
csvinput="doifile.csv"

# Name of output file
csvotput="articles.csv"

# separator of CSV file
sep1=","
sep2=","

echo "data is read from file", ${csvinput}

# Both dx.doi and DX.DOI are fine here 
grep -i "doi.org" ./${csvinput} > doi_list_tmp

# count the nubber of the line 
declare -i LINE
LINE=`cat doi_list_tmp | wc -l `
echo "The file, ${csvinput}, contains ${LINE} of data."

echo "data is saved in", ${csvotput}

# initialize the file
cat /dev/null > ${csvotput}

declare -i count=1
for (( count=1; count <= $LINE ; count++)); do 
# the 1st column corresponds doi in ${csvinput}.
        URL=`awk -F "${sep1}" '{print $1 }' doi_list_tmp | head -n ${count} | tail -1`
	# if URL does not include http://dx.doi.org/
# We must add some procedures here.
	
    REFEREED=`awk -F "${sep1}" '{print $2 }' doi_list_tmp | head -n ${count} | tail -1`
     OPENACC=`awk -F "${sep1}" '{print $3 }' doi_list_tmp | head -n ${count} | tail -1`
     INTENAT=`awk -F "${sep1}" '{print $4 }' doi_list_tmp | head -n ${count} | tail -1`
     
# derive information by curl
     curl -LH "Accept: text/bibliography; style=bibtex; charset=utf-8 " ${URL} > inf_tmp
     #     cat inf_tmp1
     
# Erase Kaigyo-code
     mv  inf_tmp inf_tmp1
     cat inf_tmp1 | tr -d '\r' | tr -d '\n' > inf_tmp2
     rm  -f inf_tmp1
     #     cat inf_tmp2
     mv  inf_tmp2 inf_tmp
     #     sed -i '' 's/^M//' inf_tmp
     #     sed -i ''  "s/–/-/g" inf_tmp
     #     sed -i ''  "s/’/-/" inf_mp
     
# extract information
    AUTHOR=`sed -ne 's/@.*{.* author={\([^}]*\)}.*}/\1/ p'  inf_tmp`
    AUTHOR=`echo ${AUTHOR} | sed -e "s/^ ?//g" `
    AUTHOR=`echo ${AUTHOR} | sed -e "s/,//g" `
    AUTHOR=`echo ${AUTHOR} | sed -e "s/and/,/g" `
    AUTHOR=\"${AUTHOR}\"
     TITLE=`sed -ne 's/@.*{.* title={\([^}]*\)}.*}/\1/ p'    inf_tmp`
     TITLE=`echo ${TITLE} | sed -e "s/^ ?//g" `
     TITLE=\"${TITLE}\"
   JOURNAL=`sed -ne 's/@.*{.* journal={\([^}]*\)}.*}/\1/ p'  inf_tmp`
   JOURNAL=`echo ${JOURNAL} | sed -e "s/^ ?//g" `
   JOURNAL=\"${JOURNAL}\"
    VOLUME=`sed -ne 's/@.*{.* volume={\([^}]*\)}.*}/\1/ p'   inf_tmp`
    VOLUME=`echo ${VOLUME} | sed -e "s/^ ?//g" `
    if [ ! -n "$VOLUME" ]; then
	 VOLUME="-"
     fi
     
      YEAR=`sed -ne 's/@.*{.* year={\([^}]*\)}.*}/\1/ p'     inf_tmp`
      YEAR=`echo ${YEAR} | sed -e "s/^ ?//g" `
     PAGES=`sed -ne 's/@.*{.* pages={\([^}]*\)}.*}/\1/ p'   inf_tmp`
     PAGES=`echo ${PAGES} | sed -e "s/^ ?//g" `
     if [ ! -n "$PAGES" ]; then
	 PAGES="-"
     fi
     
       DOI=`sed -ne 's/@.*{.* DOI={\([^}]*\)}.*}/\1/ p'      inf_tmp`
       rm -fr inf_tmp
       
       REFEREED=`echo ${REFEREED} | sed -e "s/ //g" `
       case ${REFEREED} in
	   "" | "Y" | "y" | "yes" | "Yes" | "YES" ) REFEREED="1";;
	   "" | "N" | "n" | "no" | "No" | "NO" ) REFEREED="0";;
	   * ) REFEREED="0";;
       esac
       
       INTENAT=`echo ${INTENAT} | sed -e "s/ //g" `
       case ${INTENAT} in
	   "" | "Y" | "y" | "yes" | "Yes" | "YES" ) INTENAT="1";;
	   "" | "N" | "n" | "no" | "No" | "NO" ) INTENAT="0";;
	   * ) INTENAT="0";;
       esac
       
       OPENACC=`echo ${OPENACC} | sed -e "s/ //g" `
       case ${OPENACC} in
	   "" | "Y" | "y" | "yes" | "Yes" | "YES" ) OPENACC="1";;
	   "" | "N" | "n" | "no" | "No" | "NO" ) OPENACC="0";;
	   * ) OPENACC="0";;
       esac
       
       echo    ${DOI}${sep2}${AUTHOR}${sep2}${TITLE}${sep2}${JOURNAL}${sep2}${VOLUME}${sep2}${YEAR}${sep2}${PAGES}${sep2}${REFEREED}${sep2}${INTENAT}${sep2}${OPENACC}  >> ${csvotput}
done

rm -fr doi_list_tmp

cp articles.csv articles_wou.csv
python DeleteUmlaut.py
cp articles.csv articles_utf.csv
nkf -s --overwrite articles.csv

##############################################################################
#
# Written by
#   Tomoya Takiwaki ver 1.0 
# Supponsored by
#   NEW INNOVARIVE AREA, Gravitational wave physics and astronomy: Genesis
#
##############################################################################
