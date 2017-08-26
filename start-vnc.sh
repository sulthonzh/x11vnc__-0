#!/bin/bash

pidfile=$HOME/x11vnc.pid
vncpath=/usr/bin/x11vnc
vnclog=/var/log/x11vnc
vncoptions="-display :0 -xrandr -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5904 -shared"

action=$1

function start_vpn {
	$vncpath $vncoptions > $vnclog 2>&1 &
	echo $! > $pidfile
	cat $pidfile
	sleep 1

	if netstat -plutan 2>/dev/null | grep LISTEN | grep x11vnc | grep -q 5904 ; then	
		echo "x11vnc started listening on port 5904."
	else
		echo "[!] x11vnc is not listening!"
	fi
}

if [ -f "$pidfile" ]; then
	if [ "$action" == "start" ] || [ "$action" == "" ]; then
		if [ -s "$pidfile" ] && [[ `cat $pidfile` > 0 ]]; then 
			if pgrep $vncpath ; then
				echo "x11vnc: running (pid file)."
			else
				killall $vncpath 2> /dev/null
				echo 0 > $pidfile
				start_vpn
			fi
		elif pgrep $vncpath ; then
			echo "x11vnc: running (pgrep)."
		else 
			start_vpn
		fi
	elif [ "$action" == "stop" ]; then
		killall $vncpath 2> /dev/null
		echo 0 > $pidfile
		cat $pidfile
	fi

else
	echo "[!] PIDFILE: $pidfile does not exists, cannot proceed."
fi