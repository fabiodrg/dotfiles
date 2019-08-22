#!/bin/bash

if [ -z $1 ] || [ -z $2 ]; then
	echo "Usage: $0 <usb device> <image path>"
	echo "$0 /dev/sdb manjaro-xfce-18.0-stable-minimal-x86_64.iso"
	exit
fi

# The USB path, use lsblk to find the device name
USB="$1"
# The path to ISO image
ISO_PATH="$2"

sudo umount $USB
sudo dd bs=4M if=$ISO_PATH of=$USB conv=fdatasync

# conv = fdatasync
# As described in MAN, physically write output file data before finishing. The program only returns when all data was physically written in USB flash
