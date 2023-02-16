#!/usr/bin/env bash

RESOLVED_DIR=$(dirname $(realpath $0))

source "$RESOLVED_DIR/../lib/utils.sh"

# Script version
VERSION=0.0.1

FILENAME=$(basename $0)

# Default vars
HOUR="00"
MINUTE="00"
SECOND="10"

function print_help() {
    cat <<EOF
$FILENAME
Version $VERSION

Optional arguments
  -h        Show this help message
  -d        Duration (in minutes)
  -v        Print the script version
EOF
}

function parse() {
    # Do not change the opts order !
    while getopts "H:M:S:hv" arg; do
        case $arg in
            H)
                if [[ $OPTARG -lt 0 || $OPTARG -gt 24 ]]; then
                    echo "Invalid hour (0 <= H <= 24)"
                    return 1
                fi

                HOUR=$OPTARG
                ;;

            M)
                if [[ $OPTARG -lt 0 || $OPTARG -gt 24 ]]; then
                    echo "Invalid minute (0 <= M <= 60)"
                    return 1
                fi

                MINUTE=$OPTARG
                ;;

            S)
                if [[ $OPTARG -lt 0 || $OPTARG -gt 24 ]]; then
                    echo "Invalid minute (0 <= S <= 60)"
                    return 1
                fi

                SECOND=$OPTARG
                ;;

            h)
                print_help
                exit 0
                ;;

            v)
                echo $FILENAME -- $VERSION
                exit 0
                ;;
        esac    
    done
}

function _timer() {
    local notification_id=$(notify-send "⏳ Clock starting" -p)
    local timer_format="$HOUR:$MINUTE:$SECOND"
    local seconds=$(echo "$timer_format" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')

    timer \
        $(($seconds * 1000)) \
        $notification_id \
        "normal" \
        "⏳ $timer_format"
    
    notify-send \
        -u "critical" \
        "🏆 Finish !"
}

function main() {
    parse $@ || exit 1

    _timer
}

main $@