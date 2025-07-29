#!/bin/bash

BAT_PATH="/sys/class/power_supply/BAT0"
AC_PATH="/sys/class/power_supply/AC/online"
PRIMARY="#49D196"

# Sprawdź czy bateria istnieje
if [ ! -d "$BAT_PATH" ]; then
    if [ -f "$AC_PATH" ]; then
        AC_ONLINE=$(cat "$AC_PATH")
        if [ "$AC_ONLINE" -eq 1 ]; then
            echo "%{F$PRIMARY}󱘖%{F-} AC"
        else
            echo "%{F$PRIMARY}󰂃%{F-} N/A"
        fi
    else
        echo "%{F$PRIMARY}󰂃%{F-} N/A"
    fi
    exit 0
fi

# Pobierz status i poziom naładowania
STATUS=$(cat "$BAT_PATH/status")
CAPACITY=$(cat "$BAT_PATH/capacity")

# Jeśli ładowanie
if [[ "$STATUS" == "Charging" ]]; then
    echo "%{F$PRIMARY}󰂄%{F-} $CAPACITY%"
    exit 0
fi

# Mapowanie poziomu naładowania na ikonę
if (( CAPACITY < 10 )); then
    ICON="󰁺"
elif (( CAPACITY < 20 )); then
    ICON="󰁻"
elif (( CAPACITY < 30 )); then
    ICON="󰁼"
elif (( CAPACITY < 40 )); then
    ICON="󰁽"
elif (( CAPACITY < 50 )); then
    ICON="󰁾"
elif (( CAPACITY < 60 )); then
    ICON="󰁿"
elif (( CAPACITY < 70 )); then
    ICON="󰂀"
elif (( CAPACITY < 80 )); then
    ICON="󰂁"
elif (( CAPACITY < 90 )); then
    ICON="󰂂"
else
    ICON="󰁹"
fi

echo "%{F$PRIMARY}$ICON%{F-} $CAPACITY%"