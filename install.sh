#!/bin/bash

echo "Folders creation..."
mkdir -p ~/.local/bin
mkdir -p ~/.config/systemd/user

echo "Script copy..."
cp scripts/set-wallpaper.sh ~/.local/bin/set-wallpaper.sh
chmod +x ~/.local/bin/set-wallpaper.sh

echo "systemd files copy..."
cp systemd/wallpaper.* ~/.config/systemd/user/

echo "systemd reload..."
systemctl --user daemon-reload

echo "Timer activation..."
systemctl --user enable --now wallpaper.timer

echo "Installation done !"
