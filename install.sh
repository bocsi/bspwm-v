#!/bin/bash
currentdir=$(pwd)
user=$(whoami)
for i in `cat packages.txt` ; do sudo xbps-install -Sy $i; done

cp .bashrc "$HOME/"
cp .Xresources "$HOME/"
cp .xinitrc "$HOME/"
xdg-user-dirs-update

# picom
git clone https://github.com/yshui/picom.git
cd picom
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
ninja -C build install

# Copy dotfiles
if [ -d "$HOME/.config" ] 
then
    cp -r dotfiles/* "$HOME/.config"
else
    mkdir "$HOME/.config"
    cp -r dotfiles/* "$HOME/.config"
fi

if [ -d "$HOME/.config/gtk-4.0" ] 
then
    printf "gtk-4.0 directory exists"
else
    mkdir "$HOME/.config/gtk-4.0"
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

# looks
if [ -d "$HOME/.themes" ] 
then
    printf "themes folder exists"
else
    mkdir "$HOME/.themes"
fi
#icon theme
git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
./install.sh -t turquoise -c dark
cd ..
rm -rf Nordzy-icon

# gtk theme
git clone https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git
cd Everforest-GTK-Theme
cp -r themes/Everforest-Dark-BL/ $HOME/.themes
ln -sf $HOME/.themes/Everforest-Dark-BL/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
ln -sf $HOME/.themes/Everforest-Dark-BL/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
ln -sf $HOME/.themes/Everforest-Dark-BL/gtk-4.0/assets ~/.config/gtk-4.0/assets
rm -rf Everforest-GTK-Theme
cd "$currentdir"
# wallpapers
cp -r $currentdir/wallpapers $HOME/Pictures/

# cursor theme
wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.3/Bibata-Modern-Classic.tar.gz
tar -xvf Bibata-Modern-Classic.tar.gz
mv Bibata-Modern-Classic ~/.icons/
rm -rf Bibata-*

# bspwm + sxhkd
chmod +x $HOME/.config/bspwm/bspwmrc  
chmod +x $HOME/.config/sxhkd/sxhkdrc
chmod +x $HOME/.config/polybar/launch.sh

sudo ln -s /etc/sv/qemu-ga /var/service/
sudo ln -s /etc/sv/spice-vdagentd /var/service/

# add user to video group, necessary for changing screen brightness
sudo usermod -aG video $user
