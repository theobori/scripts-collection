#!/usr/bin/env bash

# Some random features used in almost every script

function repeat() {
    local tmp=""
    
    for (( i = 0; i < $2; i++ )); do
        tmp+=$1
    done

    printf $tmp
}

# $1 Time (in seconds)
function fancy_timer() {
    echo "$(figlet -f contessa $(date -d@$(($1)) -u +%H:%M:%S))"
}

# $1 Total time (in milliseconds)
# $2 Notification ID
# $3 Urgency level
# $4 Summary
function timer() {
    local total=$(($1 / 1000))

    for (( i = total; i >= 0; i-- )); do
        notify-send \
            -r $2 \
            -u $3 \
            "$4" "$(fancy_timer $i)"
        sleep 1
    done
}
