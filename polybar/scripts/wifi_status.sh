#!/bin/bash

PRIMARY="#49D196"

# Pobierz nazwę interfejsu Wi-Fi (pierwszy interfejs typu wifi)
WIFI_DEV=$(nmcli device status | awk '$2=="wifi" {print $1; exit}')

if [ -z "$WIFI_DEV" ]; then
    ICON="󱚾"
    echo "%{F$PRIMARY}$ICON%{F-} N/A"
    exit 0
fi

# Pobierz status połączenia
STATUS=$(nmcli device status | awk -v dev="$WIFI_DEV" '$1==dev {print $3}')

# Mapowanie statusów na ikony Nerd Font
case "$STATUS" in
    connected)
        ICON="󰖩"
        ;;
    disconnected)
        ICON="󰖪"
        ;;
    connecting)
        ICON="󱚾"
        ;;
    unavailable)
        ICON="󱛅"
        ;;
    failed | *)
        ICON="󱚵"
        ;;
esac

# Zwróć wynik z ikoną w kolorze i statusem jako tekst
echo "%{F$PRIMARY}$ICON%{F-} $STATUS"