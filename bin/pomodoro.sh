#!/usr/bin/env bash

# Script version
VERSION=0.0.1

FILENAME=$(basename $0)

# Default variables
WORK_DURATION=1500000 # 25 minutes
PAUSE_DURATION=300000 # 5 minutes

function print_help() {
    cat <<EOF
$FILENAME
Version $VERSION

Optional arguments
  -h        Show this help message
  -w        Work duration (in minutes)
  -p        Pause duration (in minutes)
  -v        Print the script version
EOF
}

function parse() {
    while getopts "w:p:hv" arg; do
        case $arg in
            w)
                if [[ $OPTARG -lt 5 ]]; then
                    echo "The minimum work duration must be 5 minutes"
                    return 1
                fi

                WORK_DURATION=$(($OPTARG * 60 * 1000))
                ;;
            
            p)
                if [[ $OPTARG -lt 1 ]]; then
                    echo "The minimum pause duration must be 1 minutes"
                    return 1
                fi

                PAUSE_DURATION=$(($OPTARG * 60 * 1000))
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

# $1 Time (in seconds)
function clock() {
    echo "$(figlet -f contessa $(date -d@$(($1)) -u +%M:%S))"
}

# $1 Total time (in milliseconds)
# $2 Notification ID
# $3 Urgency level
# $4 Summary
function timer() {
    local total=$(($1 / 1000))

    for (( i = total; i > 0; i-- )); do
        notify-send \
            -r $2 \
            -u $3 \
            "$4" "$(clock $i)"
        sleep 1
    done
}

# $1 Notification ID
function work() {
    local summary="👍 Focus & work !"

    timer $WORK_DURATION $1 "normal" "$summary"
}

# $1 Notification ID
function pause() {
    local summary="⏱️ Take a pause !"
    
    timer $PAUSE_DURATION $1 "critical" "$summary"
}

function pomodoro() {
    NOTIFICATION_ID=$(notify-send "❤️ Pomodoro" -p)

    while :; do
        work $NOTIFICATION_ID
        pause $NOTIFICATION_ID
    done
}

function main() {
    parse $@ || exit 1

    pomodoro
}

main $@
