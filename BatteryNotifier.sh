#!/usr/bin/env bash

# Check shell dependencies by following commands, if they exist, then script will work fine otherwise install them:
# acpi -h
# zenity -h
# notify-send --help
# grep --help

# change this accordingly only if you have dual battery laptop, otherwise leave it with 0.
battery_to_watch=0
notify_only_when_all_the_batteries_are_full_or_low=false
sleep_time_in_seconds=240 # 4 minutes
full_battery_percent=90
low_battery__percent=25
title_ac="On AC Power"
title_dc="On Battery Power"

while true; do
  if [ $(acpi -b | grep -c Discharging) -eq 1 ]; then
    # When laptop is NOT charging.

    # only used when a specific battery is selected and notify_only_when_all_the_batteries_are_full_or_low is false.
    battery_percent=$(acpi -b | grep "Battery $battery_to_watch" | grep -P -o '[0-9]+(?=%)')

    if $notify_only_when_all_the_batteries_are_full_or_low; then
      are_batteries_low=true
      for i in $(acpi -b | grep -P -o '[0-9]+(?=%)'); do
        if [ $i -gt $low_battery__percent ]; then
          are_batteries_low=false
          break
        fi
      done
      if $are_batteries_low; then
        msg="~$low_battery__percent% power remaining.\nPlease Charge."

        notify-send "$title_dc" "$msg"
        zenity --warning --title "$title_dc" --text "$msg" --width 200 &
      fi
      # if are_batteries_low
    elif [ $battery_percent -lt 20 ]; then
      msg="$battery_percent% power remaining.\nPlease Charge."

      notify-send "$title_dc" "$msg"
      zenity --warning --title "$title_dc" --text "$msg" --width 200 &
    fi
  else
    # When laptop is charging.

    # only used when a specific battery is selected and notify_only_when_all_the_batteries_are_full_or_low is false.
    battery_percent=$(acpi -b | grep "Battery $battery_to_watch" | grep -P -o '[0-9]+(?=%)')

    if $notify_only_when_all_the_batteries_are_full_or_low; then
      are_batteries_full=true
      for i in $(acpi -b | grep -P -o '[0-9]+(?=%)'); do
        if [ $i -lt $full_battery_percent ]; then
          are_batteries_full=false
          break
        fi
      done
      if $are_batteries_full; then
        msg="Laptop ~$full_battery_percent% charged.\nRemove Charger."

        notify-send "$title_ac" "$msg"
        zenity --warning --title "$title_ac" --text "$msg" --width 200 &
      fi
    elif [ $battery_percent -gt $full_battery_percent ]; then
      msg="Laptop $battery_percent% charged.\nRemove Charger."

      notify-send "$title_ac" "$msg"
      zenity --warning --title "$title_ac" --text "$msg" --width 200 &
    fi
  fi

  # sleep 4m # Sleep for 5 minutes
  sleep $sleep_time_in_seconds
done
