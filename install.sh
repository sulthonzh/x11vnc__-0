#!/bin/bash
sudo apt update
sudo apt install xserver-xorg-video-dummy x11vnc
sudo x11vnc -storepasswd "$1" /etc/x11vnc.pass
sudo chmod a+r /etc/x11vnc.pass
sudo cp ./xorg.conf /usr/share/X11/xorg.conf.d/xorg.conf
cp ./start-vnc.sh ~/start-vnc.sh
chmod +x ~/start-vnc.sh
touch ~/x11vnc.pid
echo  "$HOME/start-vnc.sh start" >> ~/.profile
