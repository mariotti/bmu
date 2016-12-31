#! /bin/sh
#
# Updates, namely recreate a full locate.db file for the backed up data
# It takes quite a bit of time, to be clear:
# On my "test" system, which is my mac the timing is this:
#  ~>time ./bin/backmeup.updatedb.sh 
#   
#   real	12m51.286s
#   user	0m2.953s
#   sys 	0m13.892s
#
# With this size: du -ks /Volumes/<user>/MacBackUp; du -ks /Volumes/<user>/MacBackUp-BP
#  du -ks /Volumes/<any>/MacBackUp/
#         220484224	/Volumes/<any>/MacBackUp/
# waiting to finsh the command ...
#
# Using indeed a double wifi connection: The computer is on wifi, but also the disk is on wifi
# connected to the router. It is a normal 201612 wifi router.
# The backup device is a WD My Passport Wireless 2Tb.
#

# To be set in a cron job for the night or low load time, eventually with an high "nice".
#
# SETUP
. ${HOME}/bin/backmeup.setup.sh
#
${CMDUPDATEDB} --output=${BMUDIRDBLOCATE}/.locate.db --localpaths="${DIRRSYNC} ${DIRBACKUPS}"  --netpaths="${DIRRSYNC} ${DIRBACKUPS}"
#
# Remove old part indexes
# This will have to check the dates, expecially for concurrency problems.
rm -rf ${BMUDIRDBLOCATE}/.locate.db.*
