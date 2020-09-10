#!/bin/bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar --reload example &

external_monitor=$(xrandr -q | grep "HDMI-1")
echo $external_monitor
if [[ $external_monitor = *connected* ]]; then
	polybar --reload example-hdmi &
fi

#if type "xrandr"; then
#  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar --reload example &
#  done
#else
#  polybar --reload example &
#fi
