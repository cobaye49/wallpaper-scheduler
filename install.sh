#!/bin/bash

echo "📁 Création des dossiers nécessaires..."
mkdir -p ~/.local/bin
mkdir -p ~/.config/systemd/user

echo "📥 Copie du script..."
cp scripts/set-wallpaper.sh ~/.local/bin/set-wallpaper.sh
chmod +x ~/.local/bin/set-wallpaper.sh

echo "🧷 Copie des fichiers systemd..."
cp systemd/wallpaper.* ~/.config/systemd/user/

echo "🔄 Rechargement de systemd..."
systemctl --user daemon-reload

echo "✅ Activation du timer..."
systemctl --user enable --now wallpaper.timer

echo "🎉 Installation terminée !"
