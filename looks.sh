#!/bin/bash

#icon theme
git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
./install.sh -t turquoise -c dark
cd ..
rm -rf Nordzy-icon

# gtk theme
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme/
./install.sh -l -c Dark -a alt -t yellow -i void --nord
cd ..
rm -rf WhiteSur-gtk-theme/
