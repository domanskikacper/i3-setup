#!/bin/bash

# system graficzny (X11)
sudo apt install -y xorg xserver-xorg xinit

# menadżer okien (i3)
sudo apt install -y i3

# === PODSTAWOWE NARZĘDZIA ===
# launcher programów
sudo apt install -y dmenu
# menadżer plików
sudo apt install -y ranger
# terminal
sudo apt install -y xfce4-terminal
# przeglądarka
sudo apt install -y firefox-esr
# ==============================

# === AUTOSTART (startx) ===
# Uruchamianie i3 po zalogowaniu i wpisaniu 'startx'
echo "exec i3" > ~/.xinitrc