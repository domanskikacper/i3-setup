#!/bin/bash

set -e  # zakończ skrypt, jeśli wystąpi błąd

echo "Instalacja X11 i i3..."
sudo apt install -y xorg xserver-xorg xinit
sudo apt install -y i3

echo "Instalacja podstawowych narzędzi..."
sudo apt install -y dmenu ranger xfce4-terminal firefox-esr polybar picom unzip feh

echo "Instalacja lm-sensors i automatyczne wykrywanie..."
sudo apt install -y lm-sensors
yes | sudo sensors-detect

echo "Konfiguracja autostartu i3 (startx)..."
echo "exec i3" > ~/.xinitrc

STARTX_CONFIG='if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    startx
    logout
fi
'

if [ -f "$HOME/.bash_profile" ]; then
    if ! grep -Fxq 'startx' "$HOME/.bash_profile"; then
        echo "$STARTX_CONFIG" >> "$HOME/.bash_profile"
    fi
else
    echo "$STARTX_CONFIG" > "$HOME/.bash_profile"
fi

echo "Kopiowanie konfiguracji i3, picom, polybar, xfce4..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIRS=("i3" "picom" "polybar" "xfce4")

for dir in "${CONFIG_DIRS[@]}"; do
    SRC_DIR="$SCRIPT_DIR/$dir"
    DEST_DIR="$HOME/.config/$dir"
    mkdir -p "$DEST_DIR"
    cp -r "$SRC_DIR/"* "$DEST_DIR/"
done

mkdir -p "$HOME/Obrazy/Tapety"
cp "$SCRIPT_DIR/Wallpapers/city3.jpg" "$HOME/Obrazy/Tapety/"

echo "Instalacja czcionki JetBrainsMono Nerd Font..."
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -O /tmp/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -fv
rm /tmp/JetBrainsMono.zip

echo "Nadawanie uprawnień do skryptów..."
chmod +x "$HOME/.config/polybar/launch.sh"
chmod +x "$HOME/.config/polybar/scripts/cpu.sh"
chmod +x "$HOME/.config/polybar/scripts/ram.sh"
chmod +x "$HOME/.config/polybar/scripts/temp.sh"

echo "Instalacja zakończona pomyślnie!"
