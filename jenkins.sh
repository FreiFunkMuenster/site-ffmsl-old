#!/bin/sh
# 
###############################################################################################
# Jenkins-Buildscript zu erstellung der Images
# 
# Dieses Script wird nach jedem Push auf dem Freifunk Buildserver ausgführt 
# und erstelt die Images komplett neu.
# 
# Durch den Jenkins-Server werden folgende Systemvariablem gesetzt:
# $WORKSPACE - Arbeitsverzeichnis, hierhin wurde dieses repo geclont 
# $JENKINS_HOME - TBD 
# $BUILD_NUMBER - Nummer des aktuellen Buildvorganges (wird in der site.conf verwendet)
# 
###############################################################################################


# alte Build-Daten löschen 

if [ -d "$WORKSPACE/gluon" ]; then
  rm -r $WORKSPACE/gluon
fi

# Verzeichnis für Gluon-Repo erstellen und initialisieren  
git clone https://github.com/freifunk-gluon/gluon.git $WORKSPACE/gluon


# Dateien in das Gluon-Repo kopieren
# In der site.conf werden hierbei Umgebungsvariablen durch die aktuellen Werte ersetzt

mkdir $WORKSPACE/gluon/site 

cp $WORKSPACE/modules $WORKSPACE/gluon/site 
cp $WORKSPACE/site.mk $WORKSPACE/gluon/site 

perl -pe 's/\$(\w+)/$ENV{$1}/g' $WORKSPACE/site.conf > $WORKSPACE/gluon/site/site.conf 


# Gluon Pakete aktualisieren und Build ausführen 

cd $WORKSPACE/gluon
make update V=s
make V=s

# Manifest für Autoupdater erstellen und mit den Key des Servers unterschreiben 
# Der private Schlüssel des Servers muss in $JENKINS_HOME/secret liegen und das 
# Tools 'ecdsasign' muss auf dem Server verfügbar sein.
# Repo: https://github.com/tcatm/ecdsautils

cd $WORKSPACE/gluon
make manifest GLUON_BRANCH=experimental
mv images/sysupgrade/experimental.manifest images/sysupgrade/manifest
sh contrib/sign.sh $JENKINS_HOME/secret images/sysupgrade/manifest

