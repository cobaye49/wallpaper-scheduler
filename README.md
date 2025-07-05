# Wallpaper Scheduler for GNOME (Fedora)

Automatically changes your wallpaper depending on the time of day.

## Time slots

- 06:00 – 10:59 → Morning
- 11:00 – 13:59 → Noon
- 14:00 – 17:59 → Afternoon
- 18:00 – 05:59 → Evening

## Installation

```bash
git clone https://github.com/your-username/wallpaper-scheduler.git
cd wallpaper-scheduler
./install.sh
```

Make sure your wallpapers are in `~/Images/Wallpapers/` with names:
`morning.png`, `noon.png`, `afternoon.png`, `evening.png`.

## Requirements

- GNOME
- `gsettings` available
- systemd user session active
