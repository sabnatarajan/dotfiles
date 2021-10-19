#!/usr/bin/env bash

if [[ "$#" == "0" ]]; then
  BAR=default
else
  BAR=$1
fi

polybar_pid() {
  pgrep -l polybar | awk '{ print $1 }'
}

if [[ -z $polybar_pid ]]; then
  if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload $BAR &
    done
  else
    polybar --reload $BAR &
  fi
fi

