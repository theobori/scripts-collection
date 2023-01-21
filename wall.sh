#!/usr/bin/env bash

# See https://github.com/theobori/wall.sh/blob/main/wall.sh
# A supposed better version

# Script version
VERSION=0.0.1

FILENAME=$(basename $0)
COLORS=$(tput colors)

function print_help () {
    cat << HELP
Optional arguments
  -h        Show this help message and exi
  -c        Choose a color between 0 and $COLORS
  -v        Print the script version
HELP
}

function parse () {
    while getopts "c:hv" arg; do
        case $arg in
            c)
                if [[ $OPTARG -lt 0 || $OPTARG -gt $COLORS ]]; then
                    echo "0 <= c <= 256"
                    return 1
                fi
                ;;

            h)
                print_help
                return 0
                ;;
            
            v)
                echo $FILENAME -- $VERSION
                return 0
                ;;

            *)
                return 0
            ;;
        esac
    done
}

function main () {
    parse $@ || exit 1

}

main $@
