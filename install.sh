#!/bin/bash

echo "Creating required folders..."
mkdir -p ~/.local/bin
mkdir -p ~/.config/systemd/user

echo "Copying wallpaper script..."
cp scripts/set-wallpaper.sh ~/.local/bin/set-wallpaper.sh
chmod +x ~/.local/bin/set-wallpaper.sh

echo "Copying systemd unit files..."
cp systemd/wallpaper.* ~/.config/systemd/user/

echo "Reloading systemd user units..."
systemctl --user daemon-reload

echo "Enabling and starting wallpaper timer..."
systemctl --user enable --now wallpaper.timer

# Vérification/création du répertoire des fonds d'écran
WALLPAPER_DIR="$HOME/Images/Wallpapers"
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Creating wallpaper directory: $WALLPAPER_DIR"
    mkdir -p "$WALLPAPER_DIR"
fi

# Création optionnelle de fichiers placeholders
for name in morning noon afternoon evening; do
    FILE="$WALLPAPER_DIR/$name.png"
    if [ ! -f "$FILE" ]; then
        echo "Creating placeholder: $FILE"
        touch "$FILE"
    fi
done

echo "Installation complete!"
echo "ℹYou can now replace the placeholder images in $WALLPAPER_DIR with your own .png wallpapers."
