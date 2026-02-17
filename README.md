# Hyprland Dotfiles

A minimal, high-performance Hyprland configuration for daily productivity. Features Tokyo Night Dark theme, minimal animations for snappy responsiveness, and pre-configured window rules for popular applications.

![Hyprland Desktop Showcase](showcase.png)

> **Recommended:** Use on a fresh [CachyOS](https://cachyos.org/) installation with the Hyprland edition for best results.

## Configuration

- **Display:** eDP-1 at 1920x1200@165Hz with VRR enabled (! adjust in `~/.config/hypr/hyprland.conf`)
- **Theme:** Tokyo Night Dark with GTK/Qt dark mode consistency
- **Performance:** Animations disabled, blur off, VRR/VFR enabled for smooth experience
- **Layout:** Dwindle tiling with 6px inner / 12px outer gaps, 10px rounding
- **Input:** Swedish keyboard, flat mouse acceleration, tap-to-click touchpad
- **Workspaces:** Auto-assigned apps (Browser: 1, Files: 2, Code: 3, Social: 4, Media: 5-6, Creative: 7, Office: 8, VMs: 9)
- **Components:** Waybar, Wofi, Dunst, Kitty, Dolphin, Pipewire, Hyprpaper

### Monitor Configuration

The display settings are configured for my laptop. To use auto-detection:

1. Open terminal: `SUPER + Enter`
2. Run: `nano ~/.config/hypr/hyprland.conf`
3. Find the line starting with `monitor =`
4. Replace it with: `monitor = , preferred, auto, auto`
5. Save: `Ctrl + O`, then `Enter`
6. Exit: `Ctrl + X`
7. Reload: `SUPER + Shift + E` (exit) then log back in

To see your monitor name: `hyprctl monitors`

### Keyboard Layout

The default keyboard layout is Swedish (`se`). To change it:

1. Open terminal: `SUPER + Enter`
2. Run: `nano ~/.config/hypr/hyprland.conf`
3. Find `kb_layout = se`
4. Change `se` to your layout (e.g., `us`, `de`, `gb`, `fr`)
5. Save: `Ctrl + O`, then `Enter`
6. Exit: `Ctrl + X`
7. Reload: `SUPER + Shift + C` then type `hyprctl reload`

Common layouts: `us` (USA), `gb` (UK), `de` (German), `fr` (French), `es` (Spanish)

### Window Rules

Pre-configured rules for 50+ applications including floating dialogs, workspace assignments, and Picture-in-Picture positioning. Edit `~/.config/hypr/hyprland.conf` to customize.

## Setup

    chmod +x setup.sh
    ./setup.sh

## Keybinds

### Window Management

- `SUPER + Enter` — Open terminal (kitty)
- `SUPER + E` — Open Zen Browser
- `SUPER + F` — Open file manager (dolphin)
- `SUPER + Q` — Close focused window
- `SUPER + V` — Toggle fullscreen
- `SUPER + Shift + Space` — Toggle floating
- `SUPER + G` — Toggle window group
- `SUPER + D` — Toggle Wofi (app launcher)
- `SUPER + Shift + E` — Exit Hyprland

### Window Focus & Movement

- `SUPER + ←/→/↑/↓` — Focus window left/right/up/down
- `SUPER + Shift + ←/→/↑/↓` — Move window left/right/up/down

### Group Navigation

- `Alt + Tab` — Next window in group
- `Alt + Shift + Tab` — Previous window in group

### Mouse

- `SUPER + Left Click` — Drag window
- `SUPER + Right Click` — Resize window

### Workspaces

- `SUPER + 1-9,0` — Switch to workspace 1-10
- `SUPER + Shift + 1-9,0` — Move window to workspace 1-10

### Quick Launch

- `SUPER + Shift + S` — Open Steam
- `SUPER + Shift + T` — Toggle dropdown terminal
- `SUPER + Shift + D` — Open Discord
- `SUPER + Shift + M` — Open Spotify
- `SUPER + Shift + C` — Open VSCode

### Screenshots

- `Print` — Full screen screenshot → save to file
- `SUPER + Print` — Area selection → save to file
- `Shift + Print` — Area selection → copy to clipboard
- `SUPER + Shift + Print` — Current window → copy to clipboard

### Media Keys

- `XF86AudioRaiseVolume` — Volume up (3%)
- `XF86AudioLowerVolume` — Volume down (3%)
- `XF86AudioMute` — Toggle audio mute
- `XF86AudioMicMute` — Toggle mic mute
- `XF86AudioPlay` — Play/Pause
- `XF86AudioNext` — Next track
- `XF86AudioPrev` — Previous track
- `XF86MonBrightnessUp` — Brightness up (5%)
- `XF86MonBrightnessDown` — Brightness down (5%)
