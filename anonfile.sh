#!/usr/bin/env bash

# Script version
VERSION=0.0.1

FILENAME=$(basename $0)

# Default vars
API="https://api.anonfiles.com"
XDGOPEN=0

function print_help() {
    cat <<EOF
$FILENAME
Version $VERSION

Optional arguments
  -h        Show this help message
  -v        Print the script version
  -u        Filename to upload
  -d        File id to download
  -O        Open in default web browser (using xdg-open)
EOF
}

function parse() {
    while getopts "u:d:hvO" arg; do
        case $arg in
            u)
                upload_file $OPTARG
                ;;

            d)
                download_file $OPTARG
                ;;

            O)
                XDGOPEN=1
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

# $1 -> JSON response
function parse_JSON_response() {
    # JSON values
    local status=$(echo $1 | jq ".status")

    # Check file status
    if [[ $status -ne "true" ]]; then
        exit 1
    fi
    
    local url=$(echo $1 \
        | jq ".data.file.url.full" \
        | sed "s/\"//g"
    )

    if [[ $XDGOPEN -eq 1 ]]; then
        xdg-open $url
    else
        echo $url
    fi
}

# $1 -> file id to download
function download_file() {
    parse_JSON_response "$(curl -s $API/v2/file/$1/info)"
}

# $1 -> filepath to upload
function upload_file() {
    parse_JSON_response "$(curl -sF "file=@$1" $API/upload)"
}

function main() {
    parse $@ || exit 1
}

main $@
