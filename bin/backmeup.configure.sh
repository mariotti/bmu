#! /bin/sh
#
# Detect command path
# -------------------
# From: http://stackoverflow.com/questions/630372/determine-the-path-of-the-executing-bash-script
# My version was a bit more "rude" ;)
#
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi
BMU_PATH=${MY_PATH}
#
# Source BMU functions
# --------------------
#. backmeup.shellfunctions.sh 
#
# SETUP
. ${BMU_PATH}/backmeup.setup.sh
#
echo "You are configuring BMU to run from: ${BMU_PATH}"
#
echo "These directories and files will be created."
echo " -    Synchronised backup directory: ${DIRRSYNC}"
echo " - Historical data backup directory: ${DIRBACKUPS}"
echo " -         Search Indexes Directory: ${BMUDIRDBLOCATE}"
#
mkdir ${DIRRSYNC}
mkdir ${DIRBACKUPS}
mkdir ${BMUDIRDBLOCATE}
#
