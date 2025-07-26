#!/bin/bash

# Zabij wszystkie istniejące instancje Polybar
pkill -x polybar

# Czekaj, aż procesy się zakończą
while pgrep -x polybar >/dev/null; do sleep 0.2; done

# Uruchom Polybar (instancja: example)
polybar example 2>&1 | tee -a /tmp/polybar.log & disown