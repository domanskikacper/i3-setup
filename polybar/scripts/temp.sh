#!/bin/bash

ICON="%{F#49D196} TEMP%{F-}"

# Przechwyć cały output sensors (łącznie ze stderr, żeby nie wyciekł do polybara)
SENSORS_OUTPUT=$(sensors 2>/dev/null)

# Jeśli sensors nie wykrył sensorów
if echo "$SENSORS_OUTPUT" | grep -q "No sensors found"; then
  echo "$ICON N/A"
  exit 0
fi

# Pobierz temperaturę z typowych linii (można dostosować regex)
TEMP_LINE=$(echo "$SENSORS_OUTPUT" | grep -E 'Tctl:|Package id 0:' | grep -oP '\+?\d+(\.\d+)?(?=°C)' | head -n 1)

# Jeśli nadal nie znaleziono temperatury, pokaż N/A
if [[ -z "$TEMP_LINE" ]]; then
  echo "$ICON N/A"
  exit 0
fi

# Utnij po przecinku
TEMP_INT=${TEMP_LINE%.*}

# Wybór koloru
if [ "$TEMP_INT" -lt 60 ]; then
  COLOR="%{F#FFFFFF}"  # biały
elif [ "$TEMP_INT" -lt 70 ]; then
  COLOR="%{F#FFD700}"  # żółty
elif [ "$TEMP_INT" -lt 80 ]; then
  COLOR="%{F#FFA500}"  # pomarańczowy
else
  COLOR="%{F#FF0000}"  # czerwony
fi

echo -e "$ICON $COLOR${TEMP_INT}°C%{F-}"
