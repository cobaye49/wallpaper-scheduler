#!/bin/bash

# Heure en base 10
HOUR=$(date +%H)
HOUR=$((10#$HOUR))

WALLPAPER_DIR="$HOME/Images/Wallpapers"

# Détermine le préfixe du nom selon l'heure
if (( 6 <= HOUR && HOUR < 11 )); then
    PREFIX="morning"
elif (( 11 <= HOUR && HOUR < 14 )); then
    PREFIX="noon"
elif (( 14 <= HOUR && HOUR < 18 )); then
    PREFIX="afternoon"
else
    PREFIX="evening"
fi

# Recherche l'image correspondante
IMAGE=$(ls "$WALLPAPER_DIR"/${PREFIX}.* 2>/dev/null | head -n 1)
if [ -z "$IMAGE" ]; then
    echo "No wallpaper found for prefix '$PREFIX' in $WALLPAPER_DIR"
    exit 1
fi

# Détection de l'environnement de bureau
DE="${XDG_CURRENT_DESKTOP,,}"  # en minuscules

if [ -z "$DE" ]; then
    echo "Could not detect desktop environment (XDG_CURRENT_DESKTOP is empty)."
    exit 1
fi

echo "Detected desktop environment: $DE"
echo "Setting wallpaper: $IMAGE"

case "$DE" in
  *gnome*|*unity*)
    gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE"
    ;;
  *kde*)
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
      var allDesktops = desktops();
      for (i = 0; i < allDesktops.length; i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
        d.writeConfig('Image', 'file://$IMAGE');
      }"
    ;;
  *xfce*)
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$IMAGE"
    ;;
  *mate*)
    gsettings set org.mate.background picture-filename "$IMAGE"
    ;;
  *cinnamon*)
    gsettings set org.cinnamon.desktop.background picture-uri "file://$IMAGE"
    ;;
  *)
    echo "Desktop environment '$DE' not supported or unrecognized."
    ;;
esac
