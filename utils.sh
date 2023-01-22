#!/usr/bin/env bash

# Some random features used in almost every script

function repeat() {
    local tmp=""
    
    for (( i = 0; i < $2; i++ )); do
        tmp+=$1
    done

    printf $tmp
}
