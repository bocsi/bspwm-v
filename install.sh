#!/bin/bash
for i in `cat packages.txt` ; do sudo xbps-install -Sy $i; done
