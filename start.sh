#!/bin/bash

if [ ! -d ~/.vnc/ ]; then
    mkdir -p ~/.vnc/
fi
if [ ! -f ~/.Xauthority ]; then
    touch ~/.Xauthority
fi
rm -rf ~/.vnc/*.pid ~/.vnc/*.log /tmp/.X1*
vncpasswd -f <<< ${VNC_PASSWORD} > ~/.vnc/passwd
#x11vnc -create -env FD_SESS=xfce -forever -bg -usepw -rfbport 5901 &
vncserver -PasswordFile ~/.vnc/passwd
sudo dbus-daemon --config-file=/usr/share/dbus-1/system.conf
/usr/share/novnc/utils/novnc_proxy --listen 8080 --vnc 127.0.0.1:5901