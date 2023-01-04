#!/bin/bash

#icon theme
git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
./install.sh -t turquoise -c dark
cd ..
rm -rf Nordzy-icon

# gtk theme
https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git
cd Everforest-GTK-Theme
cp -r themes/Everforest-Dark-BL/ $HOME/.themes
ln -sf themes/Everforest-Dark-BL/gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
ln -sf themes/Everforest-Dark-BL/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
ln -sf themes/Everforest-Dark-BL/gtk-4.0/assets ~/.config/gtk-4.0/
rm -rf Everforest-GTK-Theme
