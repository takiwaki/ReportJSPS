#################################
# General settings
#################################

# Name of the Project
project=Summary

# Name of the Members, prefix for the files
members=M1 M2

#################################
# Settings for Articles
#################################
# suffix of the collected DOI file
# if Members= M1 M2 and doicolsuffix=-doifile.csv
# the name of the original file should be M1-doicolfile.csv M2-doicolfile.csv
doicolsuffix=-doifile.csv
doicoldata=$(addsuffix $(doicolsuffix), $(members))
$(warning "Collected data are " ${doicoldata} )

# suffix of the DOI file to submit
doisubsuffix=-articles.csv
doisubdata=$(addsuffix $(doisubsuffix), $(members))
$(warning "Temporal data are " ${doisubdata} )

doisubsummary=${project}${doisubsuffix}
$(warning "The data to submit is"  $(doisubsummary))

#################################
# Settings for Presentation
#################################
precolsuffix=-prefile.csv
precoldata=$(addsuffix $(precolsuffix), $(members))
$(warning "predata are " ${precoldata} )

presubsuffix=-presentations.csv
presubdata=$(addsuffix $(presubsuffix), $(members))
$(warning "predata are " ${presubdata} )

presubsummary=${project}${presubsuffix}
$(warning "The data to submit is"  $(presubsummary))

#################################
# Rules
#################################

all: ${doisubsummary} ${presubsummary}

.SUFFIXES: ${doicolsuffix} ${doisubsuffix} ${precolsuffix} ${presubsuffix}

${doicolsuffix}${doisubsuffix}: doi-convt.sh DeleteUmlaut.py
	cp $*${doicolsuffix} doifile.csv
	/bin/bash doi-convt.sh
	mv articles.csv $*${doisubsuffix}
	mv articles_wou.csv $*-articles_wou.csv
	mv articles_utf.csv $*-articles_utf.csv
	rm  doifile.csv
# comment out the final line  if you want to debug
${doisubsummary}: ${doisubdata}
	awk 1 ${doisubdata} > ${doisubsummary}
	rm -f *_wou.csv *_utf.csv

${precolsuffix}${presubsuffix}: pre-convt.sh
	cp $*${precolsuffix} prefile.csv
	/bin/bash pre-convt.sh
	mv presentations.csv $*${presubsuffix}

${presubsummary}: ${presubdata}
	awk 1 ${presubdata} > ${presubsummary}

clean:
	echo "cleaning the data"
	rm -f ${doisubsummary} ${doisubdata} *_wou.csv *_utf.csv  
	rm -f ${presubsummary} ${presubdata}
