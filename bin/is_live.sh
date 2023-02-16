#!/usr/bin/env bash

# Script version
VERSION=0.0.1

FILENAME=$(basename $0)

# Constants
API_URL="https://decapi.me/twitch/uptime"
OFFLINE_EMOJI="⚫"
ONLINE_EMOJI="🔴"
UNKNOWN_EMOJI="❓"

# Default variables
CHANNEL=""
DISPLAY_NAME=""

function print_help() {
    cat <<EOF
$FILENAME
Version $VERSION

Optional arguments
  -h        Show this help message
  -c        Twitch channel name
  -d        Display name
EOF
}

function parse() {
    while getopts "c:d:hv" arg; do
        case $arg in
            c)
                if [[ ${#OPTARG} -le 1 ]]; then
                    echo "Invalid channel name length (c >= 2)"
                    return 1
                fi

                CHANNEL=$OPTARG
                [[ -z $DISPLAY_NAME ]] && DISPLAY_NAME=$CHANNEL
                ;;
            
            d)
                DISPLAY_NAME=$OPTARG
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

# i3blocks button event support
function handle_button() {
    case $BLOCK_BUTTON in
        3) notify-send "👀 Streamer status module" "$OFFLINE_EMOJI: Streamer is offline
$ONLINE_EMOJI: Streamer is online
$UNKNOWN_EMOJI: Unknown satus" ;;
    esac
}

function print_status() {
    local res=$(curl --silent $API_URL/$CHANNEL)
    local emoji=""

    if [[ $res =~ "offline" ]]; then
        emoji=$OFFLINE_EMOJI
    elif [[ $res =~ "seconds" ]]; then
        emoji=$ONLINE_EMOJI
    else
        emoji=$UNKNOWN_EMOJI
    fi

    echo "$emoji $DISPLAY_NAME"
}

function main() {
    parse $@ || exit 1

    handle_button

    [[ -z $CHANNEL ]] && exit 1
    print_status
}

main $@
