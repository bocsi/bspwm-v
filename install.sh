#!/bin/bash
currentdir=$(pwd)
user=$(whoami)
for i in `cat packages.txt` ; do sudo xbps-install -Sy $i; done

cp .bashrc "$HOME/"

# Copy dotfiles
if [ -d "$HOME/.config" ] 
then
    cp -r .dotfiles/* "$HOME/.config"
else
    mkdir "$HOME/.config"
    cp -r dotfiles/* "$HOME/.config"
fi

# fonts
# Fira Code Nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
if [ -d "$HOME/.fonts" ]
then
    mkdir "$HOME/.fonts/FiraCode"
    unzip FiraCode.zip -d "$HOME/.fonts/FiraCode"
else
    mkdir "$HOME/.fonts"
    mkdir "$HOME/.fonts/FiraCode"
    unzip FiraCode.zip -d "$HOME/.fonts/FiraCode"
fi
# weather icons
git clone https://github.com/erikflowers/weather-icons.git
cd weather-icons
if [ -d "$HOME/.fonts" ]
then
    mkdir "$HOME/.fonts/WeatherIcons"
    cp -r font/* "$HOME/.fonts/WeatherIcons"
else
    mkdir "$HOME/.fonts"
    mkdir "$HOME/.fonts/WeatherIcons"
    cp -r font/* "$HOME/.fonts/WeatherIcons"
fi

cd "$currentdir"

if [ -d "$HOME/.icons" ] 
then
    cp -r icons/* "$HOME/.icons/"
else
    mkdir "$HOME/.icons"
    cp -r icons/* "$HOME/.icons/"
fi

if [ -d "$HOME/.local" ] 
then
    mkdir "$HOME/.local/bin"
    cp -r bin/* "$HOME/.local/bin"
else
    mkdir "$HOME/.local"
    mkdir "$HOME/.local/bin"
    cp -r bin/*  "$HOME/.local/bin"
fi

rm -rf weather-icons
rm -rf FiraCode.zip


cd "$HOME/.local/bin"
for x in `ls $HOME/.local/bin` ; do chmod +x $x; done

cd "$currentdir"
fc-cache -f

# wallpapers
cp -r $HOME/bspwm-v/wallpapers/ $HOME/Pictures/

chmod +x $HOME/.config/bspwm/bspwmrc  
chmod 755 $HOME/.config/sxhkd/sxhkdrc
chmod +x $HOME/.config/polybar/launch.sh

sudo ln -s /etc/sv/qemu-ga /var/service/
sudo ln -s /etc/sv/spice-vdagentd /var/service/

chmod +x $HOME/.config/bspwm/bspwmrc
chmod +x $HOME/.config/sxhkd/sxhkdrc

# add user to video group, necessary for changing screen brightness
sudo usermod -aG video $user

