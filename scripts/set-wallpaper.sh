#!/bin/bash

HOUR=$(date +%H)
HOUR=$((10#$HOUR))  # éviter les erreurs d'octal

WALLPAPER_DIR="$HOME/Images/Wallpapers"

if (( 6 <= HOUR && HOUR < 11 )); then
    IMAGE="$WALLPAPER_DIR/morning.png"
elif (( 11 <= HOUR && HOUR < 14 )); then
    IMAGE="$WALLPAPER_DIR/noon.png"
elif (( 14 <= HOUR && HOUR < 18 )); then
    IMAGE="$WALLPAPER_DIR/afternoon.png"
else
    IMAGE="$WALLPAPER_DIR/evening.png"
fi

gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE"
