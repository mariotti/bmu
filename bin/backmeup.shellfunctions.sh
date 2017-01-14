#! /bin/sh
#
bmuPromptValue() {
    msg="$1"
    var="$2"
    ttest="$3"
    echo "$msg"
    read -e val
    case $ttest in
	"-f" | "f" | "file" | "FILE" | "File")
	    if [ ! -f $val ]; then
#		echo "Input is not a file"
		return 0
	    fi
	    ;;
	"-d" | "d" | "dir" | "DIR" | "Dir" | "directory" | "DIRECTORY" | "Directory")
	    if [ ! -d $val ]; then
#		echo "Input is not a dir"
		return 0
	    fi
	    ;;
	"-n" | "n" | "notzero" | "not-zero" | "NotZero" | "NOTZERO")
	    if [ -z $val ]; then
#		echo "Input is empty"
		return 0
	    fi
	    ;;
	"-z" | "z" | "zero" | "zerolen" | "Zero" | "ZERO")
	    if [ ! -z $val ]; then
#		echo "Input is not empty"
		return 0
	    fi
	    ;;
	*)
    esac
    export $2=$val
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

