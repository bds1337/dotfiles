#!/bin/bash

external_monitor=$(xrandr -q | grep HDMI-1)
if [[ $external_monitor = *connected* ]]; then 
	xrandr --output eDP-1 --primary --mode 1920x1080 --rotate normal --output HDMI-1 --mode 1920x1080 --rotate normal --right-of eDP-1
fi
