#!/bin/bash
for i in `cat packages.txt` ; do sudo xbps-install -Sy $i; done

user=$(whoami)

# picom
#git clone --depth=1 https://github.com/void-linux/void-packages
#cd void-packages
#./xbps-src binary-bootstrap
#echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf

#git clone https://github.com/ibhagwan/picom-ibhagwan-template
#mv picom-ibhagwan-template ./srcpkgs/picom-ibhagwan

#./xbps-src pkg picom-ibhagwan
#sudo xbps-install -y --repository=hostdir/binpkgs picom-ibhagwan

#cd ..

# Copy dotfiles
if [ -d "/home/$user/.config" ] 
then
    cp -r .dotfiles/* "/home/$user/.config"
else
    mkdir "/home/$user/.config"
    cp -r dotfiles/* "/home/$user/.config"
fi
#!/bin/bash

# fonts
# Fira Code Nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
if [ -d "$HOME/.fonts" ]
then
    mkdir "$HOME/.fonts/FiraCode"
    xarchiver FiraCode.zip -d "$HOME/.fonts/FiraCode"
else
    mkdir "$HOME/.fonts"
    mkdir "$HOME/.fonts/FiraCode"
    xarchiver FiraCode.zip -d "$HOME/.fonts/FiraCode"
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
chmod 755 /home/$user/.config/sxhkd/sxhkdrc
chmod +x $HOME/.config/polybar/launch.sh

sudo ln -s /etc/sv/qemu-ga /var/service/
sudo ln -s /etc/sv/spice-vdagentd /var/service/
