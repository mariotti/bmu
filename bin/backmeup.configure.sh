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
# RollBack attempt
BMU_CONFIGURE_ROLLBACK=""
#
# Source BMU functions
# --------------------
. backmeup.shellfunctions.sh 
#
# SETUP
. ${BMU_PATH}/backmeup.setup.sh
#
echo "You are configuring BMU to run from: ${BMU_PATH}"
#
#echo "These directories and files will be created."
#echo " -    Synchronised backup directory: ${DIRRSYNC}"
#echo " - Historical data backup directory: ${DIRBACKUPS}"
#echo " -         Search Indexes Directory: ${BMUDIRDBLOCATE}"
#
#mkdir ${DIRRSYNC}
#mkdir ${DIRBACKUPS}
#mkdir ${BMUDIRDBLOCATE}
#
# BMU_DIRRSYNC
BMU_DIRRSYNC_TMP=${BMU_DIRRSYNC}
while bmuPromptValue "Please type the SYNC directory: (${BMU_DIRRSYNC_TMP})" "BMU_DIRRSYNC_TMP" "d"
do
    echo "not valid or not existing SYNC directory: ${BMU_DIRRSYNC_TMP}"
    if [ -z "$BMU_DIRRSYNC_TMP" ] ; then
	echo "Empty input value: Exiting the configuration ..."
	exit 1
    fi
    bmuPromptyNexit "Shall I create the directory for you (y/N)?"
    export BMU_DIRRSYNC=${BMU_DIRRSYNC_TMP}
    echo "MKDIR ${BMU_DIRRSYNC} TO TEST"
    BMU_CONFIGURE_ROLLBACK="${BMU_CONFIGURE_ROLLBACK} rm -rf ${BMU_DIRRSYNC};"
    break
done
#echo "debug SYNC directory: >${BMU_DIRRSYNC}< >${BMU_DIRRSYNC_TMP}<"
BMU_DIRRSYNC=${BMU_DIRRSYNC_TMP}
echo "SYNC Directory is: ${BMU_DIRRSYNC}"
#
# BMU_DIRBACKUPS
BMU_DIRBACKUPS_TMP=${BMU_DIRBACKUPS}
while bmuPromptValue "Please type the BackUp directory: (${BMU_DIRBACKUPS_TMP})" "BMU_DIRBACKUPS_TMP" "d"
do
    echo "not valid or not existing BackUp directory: ${BMU_DIRBACKUPS_TMP}"
    if [ -z "$BMU_DIRBACKUPS_TMP" ] ; then
	echo "Empty input value: Exiting the configuration ..."
	exit 1
    fi
    bmuPromptyNexit "Shall I create the directory for you (y/N)?"
    export BMU_DIRBACKUPS=${BMU_DIRBACKUPS_TMP}
    echo "MKDIR ${BMU_DIRBACKUPS} TO TEST"
    BMU_CONFIGURE_ROLLBACK="${BMU_CONFIGURE_ROLLBACK} rm -rf ${BMU_DIRBACKUPS};"
    break
done
#echo "debug BackUp directory: >${BMU_DIRBACKUPS}< >${BMU_DIRBACKUPS_TMP}<"
BMU_DIRBACKUPS=${BMU_DIRBACKUPS_TMP}
echo "BackUp Directory is: ${BMU_DIRBACKUPS}"
#
#
# BMU_DIRDBLOCATE
BMU_DIRDBLOCATE_TMP=${BMU_DIRDBLOCATE}
while bmuPromptValue "Please type the IndexDB directory: (${BMU_DIRDBLOCATE_TMP})" "BMU_DIRDBLOCATE_TMP" "d"
do
    echo "not valid or not existing IndexDB directory: ${BMU_DIRDBLOCATE_TMP}"
    if [ -z "$BMU_DIRDBLOCATE_TMP" ] ; then
	echo "Empty input value: Exiting the configuration ..."
	exit 1
    fi
    bmuPromptyNexit "Shall I create the directory for you (y/N)?"
    export BMU_DIRDBLOCATE=${BMU_DIRDBLOCATE_TMP}
    echo "MKDIR ${BMU_DIRDBLOCATE} TO TEST"
    BMU_CONFIGURE_ROLLBACK="${BMU_CONFIGURE_ROLLBACK} rm -rf ${BMU_DIRDBLOCATE};"
    break
done
#echo "debug IndexDB directory: >${BMU_DIRDBLOCATE}< >${BMU_DIRDBLOCATE_TMP}<"
BMU_DIRDBLOCATE=${BMU_DIRDBLOCATE_TMP}
echo "IndexDB Directory is: ${BMU_DIRDBLOCATE}"
#
