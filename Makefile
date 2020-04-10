
# Name of the Project
project=Summary

# Name of the Members, prefix for the files
members=M1 M2

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

presuffix=-prefile.csv
predata=$(addsuffix $(presuffix), $(members))
$(warning "predata are " ${predata} )

data= ${project}prefile.csv
predata=$(addsuffix $(presuffix), $(members))
$(warning "predata are " ${predata} )

presentationdata= $(predata:%prefile.csv=%presentations.csv)

all: ${doisubsummary}
#${presentationdata}

.SUFFIXES: ${doicolsuffix} ${doisubsuffix}

${doicolsuffix}${doisubsuffix}: doi-convt.sh
	cp $*${doicolsuffix} doi.csv
	sh doi-convt.sh
	mv articles.csv $*${doisubsuffix}
	mv articles_wou.csv $*-articles_wou.csv
	mv articles_utf.csv $*-articles_utf.csv

${doisubsummary}: ${doisubdata}
	cat ${doisubdata} > ${doisubsummary}

C01presentations.csv: pre-convt.sh C01prefile.csv
	cp C01prefile.csv prefile.csv
	sh pre-convt.sh
	mv presentations.csv C01presentations.csv

clean:
	echo "cleaning the data"
	rm -f ${doisubsummary} ${doisubdata} *_wou.csv *_utf.csv  
