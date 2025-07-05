# Wallpaper Scheduler

Wallpaper Scheduler is a simple automation tool that changes your wallpaper automatically based on the time of day.

## How it works:

- A small Bash script determines the current hour and selects the appropriate image.
- A systemd user timer runs the script every 15 minutes.
- The wallpaper is updated using gsettings, fully compatible with GNOME.

## Time slots

- 06:00 – 10:59 → Morning
- 11:00 – 13:59 → Noon
- 14:00 – 17:59 → Afternoon
- 18:00 – 05:59 → Evening

## Installation

```bash
git clone https://github.com/cobaye49/wallpaper-scheduler.git
cd wallpaper-scheduler
./install.sh
```
Copy your wallpapers named `morning`, `noon`, `afternoon`, `evening` in `~/Images/Wallpapers/`

## Manual test

You can test the script directly by running:
```bash
~/.local/bin/set-wallpaper.sh
```
## Uninstall

To disable the wallpaper scheduler:
```bash
systemctl --user disable --now wallpaper.timer
```
Then, if needed, remove files manually from:
- `~/.local/bin/set-wallpaper.sh`
- `~/.config/systemd/user/wallpaper.*`
- `~/Images/Wallpapers/ (optional)`
