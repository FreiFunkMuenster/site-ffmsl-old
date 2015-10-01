#!/bin/sh
# 
###############################################################################################
# Jenkins-Buildscript zur Erstellung der Images
# 
# Dieses Script wird nach jedem Push auf dem Freifunk Buildserver ausgeführt 
# und erstellt die Images komplett neu.
# Nach dem Build werden auch die Signaturen für den Autoupdater erstellt.
#
# Die URL des Gluon-Repositories sowie der verwendete Commit sind hier fest vorgegeben.
#  
# Durch den Jenkins-Server werden folgende Systemvariablem gesetzt:
# $WORKSPACE - Arbeitsverzeichnis, hierhin wurde dieses repo geclont 
# $JENKINS_HOME - TBD 
# $BUILD_NUMBER - Nummer des aktuellen Buildvorganges (wird in der site.conf verwendet)
#
###############################################################################################

# Globale Einstellungen 
GLUON_COMMIT=v2015.1.2

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

# Images Erstellen 
cd $WORKSPACE
sh ./build.sh $GLUON_COMMIT $BUILD_NUMBER -j6 V=s


# Manifest für Autoupdater erstellen und mit den Key des Servers unterschreiben 
# Der private Schlüssel des Servers muss in $JENKINS_HOME/secret liegen 
cd $WORKSPACE
sh ./sign.sh $GLUON_COMMIT $BUILD_NUMBER $JENKINS_HOME/secret

wget -qO - https://raw.githubusercontent.com/FreiFunkMuenster/md-fw-dl/master/config.js | sed -e "s/^version.*/version: \"$GLUON_COMMIT+$BUILD_NUMBER\",/" > config.js
