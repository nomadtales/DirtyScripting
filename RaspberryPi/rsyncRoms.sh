#!/bin/bash
rsync -av -e 'ssh -p xxxxx' --delete retropie@<xxx.xxxxx.xxx>:/volume1/Media/Games/Roms/ /home/pi/RetroPie/roms