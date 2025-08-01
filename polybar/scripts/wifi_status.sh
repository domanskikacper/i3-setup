#!/bin/bash

PRIMARY="#49D196"
GRAY="#707880"
YELLOW="#FFD700"
RED="#FF0000"

# Pobierz nazwę interfejsu Wi-Fi (pierwszy interfejs typu wifi)
WIFI_DEV=$(nmcli device status | awk '$2=="wifi" {print $1; exit}')

if [ -z "$WIFI_DEV" ]; then
    ICON="󱚾"
    echo "%{F$GRAY}$ICON%{F-}"
    exit 0
fi

# Pobierz status połączenia
STATUS=$(nmcli device status | awk -v dev="$WIFI_DEV" '$1==dev {print $3}')

# Mapowanie statusów na ikony i kolory
case "$STATUS" in
    connected)
        ICON="󰖩"
        COLOR="$PRIMARY"
        ;;
    disconnected)
        ICON="󰖪"
        COLOR="$GRAY"
        ;;
    connecting)
        ICON="󱛄"
        COLOR="$YELLOW"
        ;;
    unavailable)
        ICON="󱚼"
        COLOR="$GRAY"
        ;;
    failed)
        ICON="󱛅"
        COLOR="$RED"
        ;;
    *)
        ICON="󱚵"
        COLOR="$GRAY"
        ;;
esac

# Zwróć wynik z ikoną w odpowiednim kolorze
echo "%{F$COLOR}$ICON%{F-}"
