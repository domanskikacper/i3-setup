#!/bin/bash

PRIMARY="#49D196"
WHITE="#FFFFFF"
YELLOW="#FFD700"
ORANGE="#FFA500"
RED="#FF0000"

# Wymuszamy angielski język dla polecenia free
read total used <<< $(LANG=C free | awk '/^Mem:/ {print $2, $3}')

# Walidacja
if [[ -z "$total" || -z "$used" || "$total" -eq 0 ]]; then
    echo "%{F$PRIMARY} RAM%{F-} N/A"
    exit 1
fi

# Oblicz procent użycia pamięci
used_mem=$(( 100 * used / total ))

# Dobierz kolor
if [ "$used_mem" -lt 25 ]; then
    COLOR=$WHITE
elif [ "$used_mem" -lt 50 ]; then
    COLOR=$YELLOW
elif [ "$used_mem" -lt 75 ]; then
    COLOR=$ORANGE
else
    COLOR=$RED
fi

# Inteligentny odstęp
if [ "$used_mem" -ge 10 ]; then
    echo "%{F$PRIMARY} RAM %{F$COLOR}${used_mem}%%{F-}"
else
    echo "%{F$PRIMARY} RAM%{F$COLOR} ${used_mem}%%{F-}"
fi
