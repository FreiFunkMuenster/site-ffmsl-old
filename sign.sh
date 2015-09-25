#!/bin/sh
# 
###############################################################################################
# Buildscript zur Erstellung der Manifest-Dateien für den Autoupdater
# 
# Dieses Script wird nach dem Erstellen der Images ausgeführt und erstellt
# die Manifest-Dateien mit den Signaturen des Autoupdaters. 
# Es werden insgesamt 3 Manifest-Dateien erstellt. 
#
# Für die Signierung muss das Tool 'ecdsasign' verfügbar sein.
# Repo: https://github.com/tcatm/ecdsautils
#
# Das Script benötigt die folgenden Kommandozeilenparameter:
# - Gluon-Commit (z.B. v2014.4)
# - Build-Nummer (z.B. 114)
# - Datei, die den Schlüssel für die Signierung enthält (z.B. ~/secret)
#
###############################################################################################

# Releasenummer der zu erstellenden Images
GLUON_RELEASE=$1+$2

# Bei Ausführung auf dem Buildserver ist die Variable $WORKSPACE gesetzt 
# andernfalls wird das aktuelle Verzeichnis verwendet  

if [ "x$WORKSPACE" = "x" ]; then
	WORKSPACE=`pwd`
fi

cd $WORKSPACE/gluon

# Manifeste erstellen 
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=experimental GLUON_PRIORITY=0
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=beta GLUON_PRIORITY=1
make manifest GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=stable GLUON_PRIORITY=3

# Manifeste signieren 
sh contrib/sign.sh $3 images/sysupgrade/experimental.manifest
sh contrib/sign.sh $3 images/sysupgrade/beta.manifest
sh contrib/sign.sh $3 images/sysupgrade/stable.manifest
