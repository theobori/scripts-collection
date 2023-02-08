#!/usr/bin/env bash

# Update `scripts-collection`

# Check if running inside the git directory
# Or if this script has been installed

PROJECT_NAME="scripts-collection"
GIT_FOLDER=$(locate -r "\.git\$" | grep "$PROJECT_NAME/.git")
CLONE_PATH="$HOME/scripts-collection"

function update() {
    git pull
    sudo make install
}

if [[ -z "$GIT_FOLDER" ]]; then
    cd $GIT_FOLDER
    git pull
else
    git clone git@github.com:theobori/scripts-collection.git $CLONE_PATH
    cd $CLONE_PATH
fi

sudo make install
