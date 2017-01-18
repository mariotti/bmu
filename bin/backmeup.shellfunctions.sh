#! /bin/sh
#
bmuSetIndirectVar(){
    tmpVarName=$1
    locVarName=$1
    extVarName=$2
    #echo "debug Ind Input >$1< >$2<"
    eval tmpVarName=\$$extVarName
    #echo "debug Ind Output >$tmpVarName< >$extVarName<"
    export $locVarName=$tmpVarName
}

# bmuPromptyN()
bmuPromptyNexit() {
    msg="$1"
    echo "$msg"
    read -e val
    if [ -z $val ]; then
	echo "Exiting ..."
	exit 1
    fi
    #
    case ${val} in
	"n" | "N" | "no" | "NO" | "No")
	    echo "Exiting ..."
	    exit 1
	    ;;
	"y" | "Y" | "yes" | "YES" | "Yes")
	    ;;
	*)
	    echo "Exiting ..."
	    exit 1
	    ;;
    esac
    return 0    
}
#
# bmuPromptValue()
# - Get user prompt using the read function
#   Use it inside a while loop like:
#   while bmuPromptValue "Please type the SYNC directory: (${BMU_DIRRSYNC_TMP})" "BMU_DIRRSYNC_TMP" "d"
#   do
#       echo "not valid SYNC directory: >${BMU_DIRRSYNC_TMP}<"
#   done
#
#   The third option can be used to add a test within the read directly.
#   At present are implemented:
#   -d input must be an existing directory
#   -f input must be an existing file
#   -z input must be empty
#   -n input cannot be empty (implemented as ! -z )
#
bmuPromptValue() {
    msg="$1"
    storevar="$2"
    ttest="$3"
    echo "$msg"
    read -e val

    #echo "debug Input >$1< >$2< >$3<"
    
    if [ -z $val ]; then
	bmuSetIndirectVar "val" "$storevar"
	#echo "debug storevar: >$val<>$storevar<"
	#echo "debug val >${val}<"
    fi
    
    export $storevar=$val
    
    case $ttest in
        "-f" | "f" | "file" | "FILE" | "File")
            if [ -z $val ]; then
                echo "Input is empty for file test"
                return 0
            fi
            if [ ! -f $val ]; then
                echo "Input is not a file"
                return 0
            fi
            ;;
        "-d" | "d" | "dir" | "DIR" | "Dir" | "directory" | "DIRECTORY" | "Directory")
            if [ -z $val ]; then
                echo "Input is empty for dir test"
                return 0
            fi
            if [ ! -d $val ]; then
                echo "Input is not a dir"
                return 0
            fi
            ;;
        "-n" | "n" | "notzero" | "not-zero" | "NotZero" | "NOTZERO")
            if [ -z $val ]; then
                echo "Input is empty"
                return 0
            fi
            ;;
        "-z" | "z" | "zero" | "zerolen" | "Zero" | "ZERO")
            if [ ! -z $val ]; then
                echo "Input is not empty"
                return 0
            fi
            ;;
        *)
    esac
    export $storevar=$val
    return 1
}

bmuPromptValue_Example() {
    while bmuPromptValue "Enter a string:" "MYV" $1
    do
        echo "not valid"
    done
    echo "You wrote: >${MYV}<"
    #
}
bmuPromptValue_ExampleYN() {
    while bmuPromptValue "PShall I create the directory for you (y/N)?" "TMPYN" "n"
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
}
