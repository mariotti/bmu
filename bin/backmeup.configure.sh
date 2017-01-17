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
    while bmuPromptValue "Shall I create the directory for you (y/N)?" "TMPYN" "n"
    do
	echo "Exiting configuration ..."
	exit 1
    done
    case ${TMPYN} in
	"n" | "N" | "no" | "NO" | "No")
	    echo "Exiting configuration ..."
	    exit 1
	    ;;
	"y" | "Y" | "yes" | "YES" | "Yes")
	    export BMU_DIRRSYNC=${BMU_DIRRSYNC_TMP}
	    echo "MKDIR ${BMU_DIRRSYNC}"
	    break
	    ;;
	*)
	    echo "Exiting configuration ..."
	    exit 1
	    ;;
    esac
done
echo "debug SYNC directory: >${BMU_DIRRSYNC}< >${BMU_DIRRSYNC_TMP}<"
BMU_DIRRSYNC=${BMU_DIRRSYNC_TMP}
echo "SYNC Directory is: ${BMU_DIRRSYNC}"
#
