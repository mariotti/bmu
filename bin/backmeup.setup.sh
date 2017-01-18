#! /bin/sh
#
# SETUP
# =====
#   INDEXTYPE: Reserved for the future. possibilities at present are:
#              - locate/updatedb: implementing now and current default
#                                 basically available on every unix/linux dist
#              - codesearch: from https://github.com/google/codesearch
#                            it index also the content of text files
#                            but requires go(golang), not yet a standard
#              - zindex: from https://github.com/mattgodbolt/zindex
#                        it index also the content of text files
#                        seems a bit more complex but similar to codesearch
#
#    DIRRSYNC: Backup dirextory for current rsync data
#  DIRBACKUPS: BAckup directory for rsync, old updated/removed files
#      mydate: Date format used for the folders of backups
#                Current: +%Y%m%d-%H%M%S` FORMAT: 20130131-222618
#              Win/Samba: +%Y%m%d-%H%M`   FORMAT: 20130131-2226 with --modify-window=1 in rsync
#    OPTRSYNC: rsync Options
# CMDUPDATEDB: the updatedb command for indexing the files
#   CMDLOCATE: the locate command for searching files in the index
#   CMDFILTER: the filter command. Not used anymore
#
# FAQ
# ===
# Why not JSON or other formats for setup?
# - We are still at beta, and we require maximum but simple compatibility, more over
#   we are not yet sure what are all the machine/OS/FS dependencies,
#   this file at present contains also these dependencies as automated as possible
#   they will be removed when we have a configure and install program.
#   Also the date format is implicit here
#
# LOCAL/USER DEFINED OPTIONS
# --------------------------
# See also below INDEXING OPTIONS
#
DIRRSYNC="${HOME}/tmp/rsyncBackup"
DIRBACKUPS="${DIRRSYNC}-BP"
BMUDIRDBLOCATE="${DIRRSYNC}/.locate.dir"
# Trasition: double variables existing
BMU_DIRRSYNC="${HOME}/tmp/rsyncBackup"
BMU_DIRBACKUPS="${DIRRSYNC}-BP"
BMU_DIRDBLOCATE="${DIRRSYNC}/.locate.dir"
#
# OS Options
# ----------
BMU_INSTPATH="/usr/local"
BMU_INSTDIRNAME="/bmu"
BMU_INSTDIR="${BMU_INSTPATH}${BMU_INSTDIRNAME}"
BMU_LINKTO="/usr/local/bin/backmeup"
#
# System Options
# --------------
INDEXTYPE="locate"
mydate=`date +%Y%m%d-%H%M%S`
OPTRSYNC="-av --delete --backup" # --modify-window=1
# Trasition: double variables existing
BMU_INDEXTYPE="locate"
BMU_mydate=`date +%Y%m%d-%H%M%S`
BMU_OPTRSYNC="-av --delete --backup" # --modify-window=1
#
CMDUPDATEDB='updatedb'
CMDLOCATE='locate'
CMDFILTER='sed'
UNAME=`uname`
# Trasition: double variables existing
BMU_CMDUPDATEDB='updatedb'
BMU_CMDLOCATE='locate'
BMU_CMDFILTER='sed'
BMU_UNAME=`uname`
#
if [ "${UNAME}a" == "Darwina" ]; then
    CMDUPDATEDB='gupdatedb'
    CMDLOCATE='glocate'
    CMDFILTER='bbe -e'
    # Trasition: double variables existing
    BMU_CMDUPDATEDB='gupdatedb'
    BMU_CMDLOCATE='glocate'
    BMU_CMDFILTER='bbe -e'
fi;
#
#
# INDEXING OPTIONS
# ----------------
# Not yet used. They are at present down here as we need INDEXTYPE.
# We might consider to re-sort these options
# To be implemented.
#
# The basic idea is that we can  have locally stored indexes for
# backup search when the backup disk is off-line.
MAININDEXDIR=${DIRRSYNC}
PARTINDEXDIR=${DIRRSYNC}/.locate.db.part
# Trasition: double variables existing
BMU_MAININDEXDIR=${DIRRSYNC}
BMU_PARTINDEXDIR=${DIRRSYNC}/.locate.db.part

