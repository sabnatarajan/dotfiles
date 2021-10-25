#!/usr/bin/env bash

if [[ "$#" == "0" ]]; then
  BAR=default
else
  BAR=$1
fi

# Terminate already running bar instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload $BAR &
  done
else
  polybar --reload $BAR &
fi

