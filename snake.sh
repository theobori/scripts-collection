#!/usr/bin/env bash

source "./curses.sh"

# Script version
VERSION=0.0.1

FILENAME=$(basename $0)

# Terminal global infos
COLORS=$(tput colors)
MAX_W=$(tput cols)
MAX_H=$(tput lines)

# Default vars
COLOR=255
INTERVAL=0.07
RAINBOW=0
BLOCK="\xe2\x96\x88"

# Snake vars
DIRECTION="R"
FOOD=("-1" "-1")
X=()
Y=()

function print_help() {
    cat <<EOF
$FILENAME
Version $VERSION

Optional arguments
  -h        Show this help message
  -c        Choose a color between 0 and $COLORS
  -v        Print the script version
  -t        Timing the snake
  -r        Every block has a random color
EOF
}

function parse() {
    while getopts "c:t:hvr" arg; do
        case $arg in
            c)
                if [[ $OPTARG -lt 0 || $OPTARG -gt $COLORS ]]; then
                    echo "Invalid color (0 <= c <= 256)"
                    return 1
                fi

                COLOR=$OPTARG
                ;;

            t)
                INTERVAL=$OPTARG
                ;;

            r)
                RAINBOW=1
                ;;

            h)
                print_help
                exit 0
                ;;
            
            v)
                echo $FILENAME -- $VERSION
                exit 0
                ;;
            
            *)
                return 0
            ;;
        esac
    done
}

# Read a key then send signal to the subprocess
# Take only one argument, $1 -> PID
function handle_key() {
    read -n1 pressed_key

    case $pressed_key in
        z | Z)
            kill -SIGALRM $1
            ;;

        q | Q)
            kill -SIGUSR1 $1
            ;;

        s | S)
            kill -SIGUSR2 $1
            ;;

        d | D)
            kill -SIGBUS $1
            ;;
    esac
}

function handle_keys() {
    while :; do
        handle_key $1
    done
}

function random_food() {
    local x=$((RANDOM % $MAX_W))
    local y=$((RANDOM % $MAX_H))

    FOOD=($x $y)
}

# Sub process
function snake() {
    trap "DIRECTION=U" SIGALRM 
    trap "DIRECTION=L" SIGUSR1
    trap "DIRECTION=D" SIGUSR2
    trap "DIRECTION=R" SIGBUS

    while :; do
        if [[ ${FOOD[1]} -eq "-1" && ${FOOD[0]} -eq "-1" ]]; then
            random_food
        fi

        printf "$(tput cup ${FOOD[1]} ${FOOD[0]})\e[38;5;${COLOR}m${BLOCK}"

        sleep $INTERVAL
    done
}

function cleanup() {
    # Killing sub processes
    kill $(jobs -pr)

    curses_end
}

# Overriding curses_init from `./curses.sh`
function curses_init() {
    stty -echo
    tput smcup
    tput civis
    tput clear

    trap cleanup HUP TERM WINCH EXIT SIGINT SIGTERM
}

function main() {
    parse $@ || exit 1

    curses_init
    
    snake &
    handle_keys $!

    curses_reset
}

main $@
