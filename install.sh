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
sudo xbps-install --repository=hostdir/binpkgs picom-ibhagwan 
