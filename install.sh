#!/bin/bash
for i in `cat packages.txt` ; do sudo xbps-install -Sy $i; done

user=$(whoami)

# picom
git clone --depth=1 https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap
echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf

git clone https://github.com/ibhagwan/picom-ibhagwan-template
mv picom-ibhagwan-template ./srcpkgs/picom-ibhagwan

./xbps-src pkg picom-ibhagwan
sudo xbps-install -y --repository=hostdir/binpkgs picom-ibhagwan

# Copy dotfiles
if [ -d "/home/$user/.config" ] 
then
    cp -r .config/* "/home/$user/.config"
else
    mkdir "/home/$user/.config"
    cp -r .config/* "/home/$user/.config"
fi

# fonts
# Fira Code Nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
if [ -d "/home/$user/.fonts" ] 
then
    mkdir "/home/$user/.fonts/FiraCode"
    unzip FiraCode.zip -d "/home/$user/.fonts/FiraCode"
else
    mkdir "/home/$user/.fonts"
    mkdir "/home/$user/.fonts/FiraCode"
    unzip FiraCode.zip -d "/home/$user/.fonts/FiraCode"
fi
# weather icons
git clone https://github.com/erikflowers/weather-icons.git
cd weather-icons
if [ -d "/home/$user/.fonts" ] 
then
    mkdir "/home/$user/.fonts/WeatherIcons"
    cp -r font/* "/home/$user/.fonts/WeatherIcons"
else
    mkdir "/home/$user/.fonts"
    mkdir "/home/$user/.fonts/WeatherIcons"
    cp -r font/* "/home/$user/.fonts/WeatherIcons"
fi

cd "/home/$user/bspwm-v"

if [ -d "/home/$user/.icons" ] 
then
    cp -r icons/* "/home/$user/.icons/"
else
    mkdir "/home/$user/.icons"
    cp -r icons/* "/home/$user/.icons/"
fi

if [ -d "/home/$user/.local" ] 
then
    mkdir "/home/$user/.local/bin"
    cp -r bin/* "/home/$user/.local/bin"
else
    mkdir "/home/$user/.local"
    mkdir "/home/$user/.local/bin"
    cp -r bin/*  "/home/$user/.local/bin"
fi

rm -rf weather-icons
rm -rf FiraCode.zip


cd "/home/$user/.local/bin"
for x in `ls /home/$user/.local/bin` ; do chmod +x $x; done

cd "/home/$user/bspwm-v"
fc-cache -f

# wallpapers
cp -r /home/$user/bspwm-v/wallpapers/ /home/$user/Pictures/

chmod +x /home/$user/.config/bspwm/bspwmrc
chmod +x /home/$user/.config/sxhkd/sxhkdrc
