#! /bin/sh
#
# SETUP
. ${HOME}/bin/backmeup.setup.sh
#
# Parsing the one option
if [ -z $1 ]; then
    echo "please give a project dir.date name."
    exit 1;
fi;
#
BMUPRJDATE=${1}
#
${CMDUPDATEDB} --output=${BMUDIRDBLOCATE}/.locate.db.${BMUPRJDATE} --localpaths="${DIRBKUP}"  --netpaths="${DIRBKUP}"
