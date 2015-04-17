#!/bin/sh
# 
###############################################################################################
# Buildscript zu erstellung der Images
# 
# Dieses Script holt die passende Gluon-Version von GitHub und bereitet das 
# Arbeitsverzeichnis zum erstellen der Images vor
#
# Das Script benötigt die folgenden Kommandozeilenparameter:
# - Gluon-Commit (z.B. v2014.4)
# - Build-Nummer (z.B. 114)
# - URL des Gluon-Repositories (z.B. https://github.com/freifunk-gluon/gluon.git)
# - Optionale Parameter für make (z.B. V=s oder -j 4)
#
###############################################################################################

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi


# Verzeichnis für Gluon-Repo erstellen und initialisieren   

if [ ! -d "$WORKSPACE/gluon" ]; then
  git clone $3 $WORKSPACE/gluon
fi


# Gluon Repo aktualisieren 

cd $WORKSPACE/gluon
git fetch 
git checkout $1

# Dateien in das Gluon-Repo kopieren
# In der site.conf werden hierbei Umgebungsvariablen durch die aktuellen Werte ersetzt

if [ -d $WORKSPACE/gluon/site  ]; then
  rm -r $WORKSPACE/gluon/site
fi

mkdir $WORKSPACE/gluon/site 

cp $WORKSPACE/modules $WORKSPACE/gluon/site 
cp $WORKSPACE/site.mk $WORKSPACE/gluon/site 
cp $WORKSPACE/site.conf $WORKSPACE/gluon/site 


# Gluon Pakete aktualisieren  
cd $WORKSPACE/gluon
make update $4 $5 $6 $7 $8 $9  
make clean GLUON_RELEASE=$1+$2 $4 $5 $6 $7 $8 $9


