#!/bin/bash

#icon theme
git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
./install.sh -t turquoise -c dark
cd ..
rm -rf Nordzy-icon
