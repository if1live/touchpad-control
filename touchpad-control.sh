#!/bin/bash

XINPUT_ID=`xinput list|grep -i touchpad|awk '{print $5}'|cut --delimiter="=" -f 2`
DEVICE_ENABLED=`xinput list-props $XINPUT_ID|grep -i "device enabled"|awk {'print $4'}`

function enable_touchpad() {
	#/usr/bin/synclient TouchpadOff=0
	xinput --enable $XINPUT_ID
}

function disable_touchpad() {
	#/usr/bin/synclient TouchpadOff=1
	xinput --disable $XINPUT_ID
}

function toggle_touchpad() {
	if [[ $DEVICE_ENABLED == "1" ]]; then
		disable_touchpad
	else
		enable_touchpad
	fi
}

function print_touchpad_state() {
	echo $DEVICE_ENABLED
}

case $1 in
	"1")
		enable_touchpad
		;;
	"0")
		disable_touchpad
		;;
	"toggle")
		toggle_touchpad
		;;
	"")
		print_touchpad_state
		;;
	*)
		echo "unknown command"
		;;
esac
