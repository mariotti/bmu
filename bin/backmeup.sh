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
# SETUP
. ${BMU_PATH}/backmeup.setup.sh
#
# Parsing the one option
if [ -z $1 ]; then
    echo "please give a dir name."
    exit 1;
fi;
#Remove trailing / It creates a project directory
TOBACKUP=`dirname $1`/`basename $1`
PRJDIR=`basename ${1}`

#Define a rsync backup dir. It is new at each time we run up to mydate granularity
DIRBKUP="${DIRBACKUPS}/${PRJDIR}/B-${mydate}"
OPTBKUP=" --backup-dir=${DIRBKUP}"
#
rsync ${OPTRSYNC} ${OPTBKUP} ${TOBACKUP} ${DIRRSYNC}/${PRJDIR}
#
# Create List Files
if [ -d ${DIRBACKUPS}/${PRJDIR} ]; then
  cd ${DIRBACKUPS}
  find ${PRJDIR}/B-${mydate} > ${PRJDIR}/B-${mydate}.filelist
fi;
#
### END OF RSYNC JOB ###
#
# INDEXING
# Add Eventual changed files
if [ -d ${DIRBACKUPS}/${PRJDIR} ]; then
    ${CMDUPDATEDB} --output=${BMUDIRDBLOCATE}/.locate.db.${PRJDIR}.${mydate} --localpaths="${DIRBKUP}"  --netpaths="${DIRBKUP}"
fi
#
