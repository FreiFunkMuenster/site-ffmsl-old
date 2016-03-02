#!/bin/sh
# 
###############################################################################################
# 
# Dieses Script holt die vorgegebene Gluon-Version in das aktuelle Arbeitsverzeichnis 
# uns erstellt die Images.
#
# Das Script benötigt die folgenden Kommandozeilenparameter:
# - Gluon-Commit (z.B. v2014.4)
# - Build-Nummer (z.B. 114)
# - Ordner in dem abgelegt werden soll (z.B. domaene01) 
# - Optionale Parameter für make (z.B. V=s oder -j 4)
#  
###############################################################################################

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

letzterBefehlErfolgreich () {
	if [ $? != 0 ]
	then
		echo "Etwas ist schief gelaufen. Beende Kompilierungsprozess, Exitstatus $?."
		exit $?;
	fi
}
		

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

# Build Verzeichnis vorbereiten
mkdir /var/www/html/$3/versions/v$2
letzterBefehlErfolgreich;
cd $WORKSPACE
sh ./prepare.sh $1
letzterBefehlErfolgreich;

# Gluon Pakete aktualisieren und Build ausführen 
cd $WORKSPACE
sh ./compile.sh $1 $2 ar71xx-generic GLUON_IMAGEDIR=/var/www/html/$3/versions/v$2 $4 $5 $6 $7 $8 $9
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 ar71xx-nand GLUON_IMAGEDIR=/var/www/html/$3/versions/v$2 $4 $5 $6 $7 $8 $9
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 mpc85xx-generic GLUON_IMAGEDIR=/var/www/html/$3/versions/v$2 $4 $5 $6 $7 $8 $9 
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 x86-generic GLUON_IMAGEDIR=/var/www/html/$3/versions/v$2 $4 $5 $6 $7 $8 $9 
letzterBefehlErfolgreich;
sh ./compile.sh $1 $2 x86-kvm_guest GLUON_IMAGEDIR=/var/www/html/$3/versions/v$2 $4 $5 $6 $7 $8 $9 
letzterBefehlErfolgreich;
