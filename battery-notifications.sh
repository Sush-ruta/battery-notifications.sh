#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)

V1="Charging"

V2=$(grep -w "Charging" /sys/class/power_supply/BAT1/status)

V3=$(grep -Eo '[0-9]{1,}' /sys/class/power_supply/BAT1/capacity)

if [ "$V1" = "$V2" ] && [ "$V3" -ge 95 ]; then
    notify-send -u critical "Remove Charger!"
fi

U1="Discharging"

U2=$(grep -w "Discharging" /sys/class/power_supply/BAT1/status)

if [ "$U1" = "$U2" ] && [ "$V3" -le 20 ]; then
    notify-send -u critical "Plug in Charger!"
fi
