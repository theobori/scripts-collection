#!/usr/bin/env bash

cd /tmp

# Download then extract files
curl -L "https://discord.com/api/download?platform=linux&format=tar.gz" | tar -xvz

# Update the icon value then install 
sed -i "s/Icon=discord/Icon=\/usr\/share\/discord\/discord.png/g" Discord/discord.desktop
sudo mv Discord/discord.desktop /usr/share/applications 

sudo mv Discord /usr/share/discord
sudo ln -sf /usr/share/discord/Discord /usr/bin

# Update desktop files
sudo update-desktop-database /usr/share/applications
