#!/bin/bash

# Heure en base 10
HOUR=$(date +%H)
HOUR=$((10#$HOUR))

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

# Détection de l'environnement de bureau
DE="${XDG_CURRENT_DESKTOP,,}"  # tout en minuscules

echo "Detected desktop environment: $DE"
echo "Setting wallpaper: $IMAGE"

case "$DE" in
  *gnome*|*unity*)
    gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE"
    ;;
  *kde*)
    # Utilisation de DBus pour KDE Plasma
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
      var allDesktops = desktops();
      for (i=0;i<allDesktops.length;i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
        d.writeConfig('Image', 'file://$IMAGE');
      }"
    ;;
  *xfce*)
    # Pour XFCE (suppose xfconf-query installé)
    DISPLAY_NUM=$(echo $DISPLAY | sed 's/[^0-9]*//g')
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$IMAGE"
    ;;
  *mate*)
    gsettings set org.mate.background picture-filename "$IMAGE"
    ;;
  *cinnamon*)
    gsettings set org.cinnamon.desktop.background picture-uri "file://$IMAGE"
    ;;
  *)
    echo "Desktop environment '$DE' not supported yet."
    ;;
esac
