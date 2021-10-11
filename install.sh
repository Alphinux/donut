#!/usr/bin/env bash

CWD=$(pwd)
OUT=$(pacman -Q |  grep gcc)
PLATFORM=$(uname)

if [ "$PLATFORM" != "Linux" ]; then
	echo "This script currently only supports Linux."
	exit 1
fi

if [ "$OUT" = "" ]; then 
	echo "You need to install gcc for this installation script."
fi

if [ "$1" = "-h" ]; then
	echo "This is the install script for Donut. If you want to install this command, use the option -S. If you want to uninstall Donut use -R."
	exit 0
fi

if [ ${EUID} -ne 0 ]; then
    echo "This script must be run as root. Cancelling" >&2
    exit 1
elif [ "$1" = "-S" ]; then
	gcc $CWD/Spinning_Donut.c -o /usr/local/bin/donut -lm && echo "Installation finished" || echo "Installation failed"
	exit 0
elif [ "$1" = "-R" ]; then
	rm -f /usr/local/bin/donut && echo "Uninstallation finished" || echo "Uninstallation failed"
	exit 0
else
	echo "No valid option specified"
fi
