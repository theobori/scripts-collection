#!/usr/bin/env bash

# Minimal "curses" features

# Initialize the terminal
curses_init() {
    stty -echo
    tput smcup
    tput civis
    tput clear
    trap curses_end HUP TERM INT WINCH
}

# Reset the terminal attributes with the default ones
curses_reset() {
    tput reset
    tput rmcup
    tput cnorm
    stty echo
    echo "$(tput sgr0)"
}

# End the curses session
curses_end() {
    curses_reset
    exit 0
}
