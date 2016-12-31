#! /bin/sh
#
# SETUP
. ${HOME}/bin/backmeup.setup.sh
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
${CMDUPDATEDB} --output=${BMUDIRDBLOCATE}/.locate.db.${PRJDIR}.${mydate} --localpaths="${DIRBKUP}"  --netpaths="${DIRBKUP}"
#
