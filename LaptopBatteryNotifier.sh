#!/usr/bin/env bash

# Check shell dependencies by following commands, if they exist, then script will work fine otherwise install them:
# upower -h
# bc -h
# zenity -h
# notify-send --help
# grep --help

# Helpful Sources:
# https://tldp.org/LDP/abs/html/comparison-ops.html
# https://stackoverflow.com/a/16854326
# https://stackoverflow.com/a/34286545
# How to convert floating point number to integer:
# https://unix.stackexchange.com/a/89748
# Source, Bash comparison operators:
# https://tldp.org/LDP/abs/html/comparison-ops.html

full_battery_percent=95
low_battery__percent=20

sleep_time_in_seconds=300 # 5 minutes

title_ac="On AC Power"
title_dc="On Battery Power"
energy_full_total='0'

while read battery_path; do
  temp=$(upower -i $battery_path | grep 'energy-full:' | grep -Eo '[0-9]+(\.[0-9]+)*')
  energy_full_total=$(bc -l <<<"(${temp}*100)+${energy_full_total}")
done <<<$(upower -e | grep BAT)
energy_full_total=${energy_full_total%.*}
# this is why we need to create the while loop like this:
# bash for loop save value in outer scope variable.

while true; do
  energy_now_total='0'

  while read battery_path; do
    temp=$(upower -i $battery_path | grep 'energy:' | grep -Eo '[0-9]+(\.[0-9]+)*')
    energy_now_total=$(bc -l <<<"(${temp}*100)+${energy_now_total}")
  done <<<$(upower -e | grep BAT)
  energy_now_total=${energy_now_total%.*}

  if [ $energy_now_total -ge $energy_full_total ]; then
    energy_now_total="100"
  else
    energy_now_total=$(bc -l <<<"${energy_now_total}/${energy_full_total}*100")
    energy_now_total=${energy_now_total%.*}
  fi


  if [ $(upower -i $(upower -e | grep BAT) | grep 'state:' | grep -c discharging) -eq 1 ]; then
    # when not charging

    if [ $energy_now_total -le $low_battery__percent ]; then
      msg="$energy_now_total% power remaining.\nPlease Charge."
      notify-send "$title_dc" "$msg"
      zenity --warning --title "$title_dc" --text "$msg" --width 200 &
    fi

  else
    # when charging

    if [ $energy_now_total -ge $full_battery_percent ]; then
      msg="Laptop $energy_now_total% charged.\nRemove Charger."
      notify-send "$title_ac" "$msg"
      zenity --warning --title "$title_ac" --text "$msg" --width 200 &
    fi

  fi

  sleep $sleep_time_in_seconds
  # OR
  # sleep 5m # Sleep for 5 minutes
done
