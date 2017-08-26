#!/bin/bash

sudo apt-get install x11vnc
sudo x11vnc -storepasswd "$1" /etc/x11vnc.pass
sudo chmod a+r /etc/x11vnc.pass
sudo cp ./xorg.conf /usr/share/X11/xorg.conf.d/xorg.conf
chmod +x $HOME/start-vnc.sh
touch ~/x11vnc.pid
echo  "$HOME/start-vnc.sh start" >> ~/.profile