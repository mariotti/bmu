#! /bin/sh
#
# SETUP
. bin/backmeup.setup.sh
#
${CMDLOCATE} -d ${BMUDIRDBLOCATE}/.locate.db ${@:1}
#
# NOTES
#
# The funny thing is that, because of the locate.db format, and
# our choosen date format and directory structure,
# the results appears already ordered by date.
#
# TODO
# Check to exclude the -d option from this particular
# version of locate. As it makes little sense to allow it.
# For specific searches (when we might need the -d option)
# we can use directly the original "locate" command.
# An exception is to provide facilites for a future GUI.
# But in that case we create the specific facility.
#
