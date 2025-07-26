#!/bin/bash

PRIMARY="#49D196" # Zastąp ręcznie jeśli chcesz
WHITE="#FFFFFF"
YELLOW="#FFD700"
ORANGE="#FFA500"
RED="#FF0000"

cpu1=($(grep '^cpu ' /proc/stat))
sleep 0.5
cpu2=($(grep '^cpu ' /proc/stat))

user=$((cpu2[1] - cpu1[1]))
nice=$((cpu2[2] - cpu1[2]))
system=$((cpu2[3] - cpu1[3]))
idle=$((cpu2[4] - cpu1[4]))

total=$((user + nice + system + idle))
usage=$(( (user + nice + system) * 100 / total ))

# Wybierz kolor w zależności od użycia
if [ "$usage" -lt 25 ]; then
    COLOR=$WHITE
elif [ "$usage" -lt 50 ]; then
    COLOR=$YELLOW
elif [ "$usage" -lt 75 ]; then
    COLOR=$ORANGE
else
    COLOR=$RED
fi

echo "%{F$PRIMARY} CPU %{F$COLOR}${usage}%%{F-}"
