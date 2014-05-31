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

# Globale Einstellungen 
export GLUON_URL=https://github.com/freifunk-gluon/gluon.git
export GLUON_COMMIT=e7e8445df404c44add352524765fc4e6fd228cc4
export GLUON_RELEASE=0.4.1+$BUILD_NUMBER
export GLUON_BRANCH=experimental

# alte Build-Daten löschen 

if [ -d "$WORKSPACE/gluon" ]; then
  rm -r $WORKSPACE/gluon
fi

# Verzeichnis für Gluon-Repo erstellen und initialisieren  
git clone $GLUON_URL $WORKSPACE/gluon

cd $WORKSPACE
git checkout $GLUON_COMMIT

# Dateien in das Gluon-Repo kopieren
# In der site.conf werden hierbei Umgebungsvariablen durch die aktuellen Werte ersetzt

mkdir $WORKSPACE/gluon/site 

cp $WORKSPACE/modules $WORKSPACE/gluon/site 
cp $WORKSPACE/site.mk $WORKSPACE/gluon/site 
cp $WORKSPACE/site.conf $WORKSPACE/gluon/site 


# Gluon Pakete aktualisieren und Build ausführen 
cd $WORKSPACE/gluon
make update GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$GLUON_BRANCH
make GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$GLUON_BRANCH

# Manifest für Autoupdater erstellen und mit den Key des Servers unterschreiben 
# Der private Schlüssel des Servers muss in $JENKINS_HOME/secret liegen und das 
# Tools 'ecdsasign' muss auf dem Server verfügbar sein.
# Repo: https://github.com/tcatm/ecdsautils

cd $WORKSPACE/gluon
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$GLUON_BRANCH
mv images/sysupgrade/experimental.manifest images/sysupgrade/manifest
sh contrib/sign.sh $JENKINS_HOME/secret images/sysupgrade/manifest

