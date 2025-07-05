#!/bin/bash

echo "Creating required folders..."
mkdir -p ~/.local/bin
mkdir -p ~/.config/systemd/user

echo "Copying wallpaper script..."
cp scripts/set-wallpaper.sh ~/.local/bin/set-wallpaper.sh
chmod +x ~/.local/bin/set-wallpaper.sh

echo "Copying systemd unit files..."
cp systemd/wallpaper.* ~/.config/systemd/user/

# Vérification/création du répertoire des fonds d'écran
WALLPAPER_DIR="$HOME/Images/Wallpapers"
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Creating wallpaper directory: $WALLPAPER_DIR"
    mkdir -p "$WALLPAPER_DIR"
fi

echo "Installing default wallpapers..."

for name in morning noon afternoon evening; do
    # Rechercher le fichier correspondant dans default-wallpapers/
    FILE=$(ls "default-wallpapers/$name".* 2>/dev/null | head -n 1)
    if [ -n "$FILE" ]; then
        DEST="$HOME/Images/Wallpapers/$(basename "$FILE")"
        if [ ! -f "$DEST" ]; then
            echo "Copying $FILE → $DEST"
            cp "$FILE" "$DEST"
        else
            echo " $DEST already exists — skipping (user may have customized it)"
        fi
    else
        echo "No default image found for '$name'"
    fi
done

echo "Reloading systemd user units..."
systemctl --user daemon-reload

echo "Enabling and starting wallpaper timer..."
systemctl --user enable --now wallpaper.timer

echo "Installation complete!"
echo "You can now replace the images in $WALLPAPER_DIR with your own wallpapers."
