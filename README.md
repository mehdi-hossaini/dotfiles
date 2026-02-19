# CachyOS Hyprland Dotfiles — Tokyo Night Dark Theme · Arch Linux

[![Hyprland](https://img.shields.io/badge/Hyprland-v0.53+-blue?style=flat-square&logo=linux)](https://github.com/hyprwm/Hyprland)
[![Waybar](https://img.shields.io/badge/Waybar-Vertical%20Bar-purple?style=flat-square)](https://github.com/Alexays/Waybar)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![CachyOS](https://img.shields.io/badge/CachyOS-Hyprland%20Edition-orange?style=flat-square)](https://cachyos.org)

**The CachyOS Hyprland edition ships with no dotfiles by default.** This repo fills that gap — a complete, opinionated **CachyOS Hyprland configuration** ready for daily use out of the box. Tokyo Night Dark theme, vertical Waybar with live Cava audio visualizer, 130+ pre-configured window rules, Wofi power & WiFi menus, dropdown Kitty terminal, and a single automated install script that also tunes your network stack and NVMe scheduler.

<div align="center">
  <video src="showcase.mp4" width="100%" controls muted autoplay loop>
    <p>Your browser does not support the video tag. <a href="showcase.mp4">Click here to watch the showcase.</a></p>
  </video>
</div>

> [!NOTE]
> Designed for a **fresh [CachyOS](https://cachyos.org/) Hyprland edition** install — the perfect starting point since it ships with no dotfiles. Also works on any Arch Linux + Hyprland setup.

---

## 🚀 Install

```bash
git clone https://github.com/mehdi-hossaini/dotfiles.git ~/dotfiles
cd ~/dotfiles && chmod +x setup.sh && ./setup.sh
```

**The script handles:** mirrors → system upgrade → packages → configs → wallpaper → BBR+CAKE networking → ADIOS NVMe scheduler → reboot prompt.

---

<details>
<summary><strong>⚙️ Post-Install Setup</strong> — monitor, keyboard layout</summary>

### 1. Auto-Detect Monitor
```bash
sed -i 's/^monitor = .*/monitor = , preferred, auto, auto/' ~/.config/hypr/hyprland.conf
```

### 2. Set Keyboard Layout
Default is `se` (Swedish). Change to yours:
```bash
sed -i 's/kb_layout = se/kb_layout = us/' ~/.config/hypr/hyprland.conf
```
Layouts: `us` · `gb` · `de` · `fr` · `es` · `no` · `fi` · `dk`

> [!TIP]
> Log out and back in (`Super+Shift+E`) to apply all changes.

</details>

---

<details>
<summary><strong>⌨️ Keybinds</strong> — window management, navigation, utilities, media</summary>

### Window Management
| Key | Action |
|-----|--------|
| `SUPER + Enter` | Terminal (Kitty) |
| `SUPER + B` | Zen Browser |
| `SUPER + E` | File manager (Dolphin) |
| `SUPER + D` | App launcher (Wofi) |
| `SUPER + Q` | Close window |
| `SUPER + V` | Toggle floating |
| `SUPER + F` | Fullscreen |
| `SUPER + Shift + T` | Dropdown terminal (slides from top) |
| `SUPER + Shift + E` | Exit Hyprland |

### Navigation & Workspaces
| Key | Action |
|-----|--------|
| `SUPER + ←/→/↑/↓` | Focus window |
| `SUPER + Shift + ←/→/↑/↓` | Move window |
| `SUPER + 1–6` | Switch workspace |
| `Alt + Tab` | Cycle group |

### Utilities
| Key | Action |
|-----|--------|
| `SUPER + Backspace` | Power menu (Lock / Logout / Suspend / Reboot / Shutdown) |
| `SUPER + N` | WiFi menu (connect/disconnect via nmcli) |
| `Print` | Screenshot → file |
| `SUPER + Print` | Area screenshot → file |
| `Shift + Print` | Area screenshot → clipboard |

### Media
| Key | Action |
|-----|--------|
| `Volume Up/Down` | ±3% volume |
| `Brightness Up/Down` | ±5% brightness |
| `Play / Pause / Next / Prev` | Media controls |

### Mouse
| Action | Result |
|--------|--------|
| `SUPER + LMB drag` | Move floating window |
| `SUPER + RMB drag` | Resize window |
| `SUPER + Scroll` | Cycle workspace |
| Drag border (20px area) | Resize tiled window |

</details>

---

<details>
<summary><strong>📦 Required Packages</strong> — auto-installed + recommended extras</summary>

All of the following are installed automatically by `setup.sh`:

| Package | Purpose |
|---------|---------|
| `hyprland` | Wayland tiling compositor |
| `kitty` | GPU-accelerated terminal |
| `dolphin` | KDE file manager |
| `dunst` | Notification daemon |
| `hyprpaper` | Wallpaper daemon |
| `waybar` | Status bar |
| `wofi` | Application launcher |
| `polkit-kde-agent` | Authentication agent |
| `brightnessctl` | Backlight control |
| `playerctl` | Media key control |
| `pipewire` + `pipewire-pulse` + `wireplumber` | Audio stack |
| `qt5-wayland` + `qt6-wayland` | Qt Wayland integration |
| `xdg-desktop-portal-hyprland` | Screen sharing, file pickers |
| `ttf-jetbrains-mono-nerd` | Primary Nerd Font |
| `cachyos-gaming-meta` | Gaming optimizations |
| `steam` | Game platform |
| `grim` + `slurp` | Wayland screenshot tools |
| `wl-clipboard` | Clipboard (Wayland) |
| `cava` | Audio visualizer |

<details>
<summary><strong>Also recommended — install manually (by priority)</strong></summary>

**🔺 High Priority — Performance (strongly recommended on CachyOS)**
- **Kernel:** Switch to `linux-cachyos-eevdf` via **CachyOS Kernel Manager** — lower latency and better desktop responsiveness
- **CPU Scheduler:** Use `scx_lavd` via **schedExt GUI Manager** — latency-aware scheduler; great for gaming and interactive use

**🟡 Medium Priority — Core Functionality**
- `zen-browser` — default browser (`Super+B`)
- `fish` — shell (config + welcome banner included)
- `hyprlock` — screen locker (required by power menu `Lock`)
- `pavucontrol` — audio GUI (click volume module in Waybar)
- `nmcli` / `networkmanager` — required by WiFi menu (`Super+N`)

**🟢 Low Priority — Optional (configs included, not in setup.sh)**
- `btop` — system monitor
- `helix` — modal text editor

</details>
</details>

---

<details>
<summary><strong>⚙️ Features</strong> — theme, layout, performance, components</summary>

| Category | Detail |
|----------|--------|
| **Theme** | Tokyo Night Dark — consistent across all components |
| **Bar** | Vertical left-side Waybar, 65px, Cava visualizer in center |
| **Workspaces** | 6 persistent, Nerd Font icons (browser, code, chat, discord, game, 🎮) |
| **Tiling** | Dwindle — 6px inner / 12px outer gaps, 10px rounded corners |
| **Window Rules** | 130+ named rules — dialogs, PiP, games, Steam, IDEs auto-handled |
| **Borders** | Blue→Purple gradient (active), dimmed bg (inactive) |
| **Performance** | Animations disabled, VRR + VFR enabled, `allow_tearing = true` |
| **Networking** | BBR TCP + CAKE qdisc auto-tuned per interface |
| **I/O** | ADIOS scheduler on NVMe — persistent via udev rule |
| **Terminal** | Kitty — Catppuccin Mocha, 92% opacity, blur, tabs, splits |
| **Launcher** | Wofi — fuzzy search, icons, 450×320, centered |
| **Notifications** | Dunst — Tokyo Night styled |
| **Shell** | Fish with welcome banner |
| **Auth** | polkit-kde-agent — auto-floated and centered |
| **Cursor** | Breeze 24px, auto-hides after 5s + on keypress |
| **GTK/Qt** | Both forced dark via gsettings + KDE env vars |

</details>

---

<details>
<summary><strong>🎨 Visual Design</strong> — colors, effects, Waybar layout</summary>

**Tokyo Night Dark palette — applied everywhere:**

| Element | Color | Role |
|---------|-------|------|
| Active border | `#7aa2f7` → `#bb9af7` 45° | Blue-to-purple gradient |
| Inactive border | `#24283b` 87% opacity | Recedes into background |
| Waybar bg | `rgba(26,27,38,0.88)` | Semi-transparent dark |
| CPU | `#7dcfff` cyan | Processing |
| RAM | `#bb9af7` purple | Memory |
| Network | `#7aa2f7` blue | Connectivity |
| Volume | `#ff9e64` orange | Audio |
| Tray | `#9ece6a` green | System health |
| Power | Yellow (logout) + Red (shutdown) | Clear danger hierarchy |

**Visual effects:**
- 10px corner rounding on all windows
- 92% terminal opacity — aware without blur
- Cava audio visualizer (rotated vertical) — reacts to music in real time
- Hover glow on all Waybar modules
- Urgent workspace pulses red
- Cursor auto-hides after 5s + on keypres

</details>

---

<details>
<summary><strong>📱 Mouse vs Keyboard</strong> — daily usability breakdown</summary>

| Task | Keyboard | Mouse |
|------|----------|-------|
| Open app | `Super+D` | Click CachyOS logo on Waybar |
| Switch workspace | `Super+1–6` | Click workspace button |
| Move window | `Super+Shift+Arrows` | `Super+LMB` drag |
| Resize window | Drag border (20px grab) | `Super+RMB` drag |
| Screenshot | `Print` / `Super+Print` | — |
| Power | `Super+Backspace` | Click shutdown button |
| Volume | Media keys | Click volume → Pavucontrol |
| Terminal | `Super+Enter` | — |
| Dropdown terminal | `Super+Shift+T` | — |

> Every critical action is reachable by mouse via Waybar — but keyboard shortcuts make it significantly faster. True daily-driver setup; no Vi-mode required.

</details>

---

<details>
<summary><strong>📂 What's Included</strong> — full file tree</summary>

```
dotfiles/
├── setup.sh                        # Automated installer
├── hello.jpg                       # Default wallpaper
└── experimental/
    ├── hypr/
    │   ├── hyprland.conf           # 2988-line master config
    │   ├── hyprpaper.conf          # Wallpaper setup
    │   └── scripts/
    │       ├── kitty-dropdown.sh   # Dropdown terminal toggle
    │       └── kde-dark-mode.sh    # GTK/Qt dark mode applicator
    ├── waybar/
    │   ├── config.jsonc            # Vertical bar config
    │   ├── style.css               # Tokyo Night CSS (349 lines)
    │   └── scripts/cava.sh         # Cava bridge script
    ├── wofi/
    │   ├── config                  # Fuzzy launcher config
    │   ├── style.css               # Matching theme
    │   └── scripts/
    │       ├── power.sh            # Power menu
    │       └── wifi.sh             # WiFi connect/disconnect
    ├── kitty/kitty.conf            # Catppuccin Mocha, tabs, splits, blur
    ├── dunst/                      # Notification style
    ├── fish/
    │   ├── config.fish             # Shell init
    │   └── welcome.sh              # Startup system info banner
    ├── btop/                       # Resource monitor theme
    └── helix/                      # Modal editor config (not in setup.sh)
```

</details>

---

<details>
<summary><strong>🧩 Components Deep Dive</strong> — per-config breakdown</summary>

### Hyprland (`hyprland.conf`)
2988-line monolithic config:
- **Env vars** — Wayland forced for GTK, Qt, SDL, Electron, Java
- **Startup** — DBus → polkit → Pipewire → Dunst → XDG portal → Hyprpaper → `sleep 1 && waybar`
- **Decoration** — 10px rounding, shadow on, blur off (performance)
- **Animations** — disabled (`enabled = no`); bezier curves defined, easy to re-enable
- **Input** — touchpad tap-to-click, scroll 0.5x, flat accel, numlock on
- **Window rules** — 130+ named rules across all app categories

### Waybar (`config.jsonc` + `style.css`)
- Left: CachyOS logo (→ Wofi on click) + workspace switcher
- Center: Cava bars (rotated 90°, real-time audio)
- Right: CPU%, RAM GB, Network, Volume%, Clock, Tray, Logout, Power

### Kitty (`kitty.conf`)
- Font: JetBrains Mono Nerd, 12px, ligatures on
- Theme: Catppuccin Mocha
- Opacity: 92% + 24px blur, dynamic opacity toggle (`Ctrl+Shift+F6`)
- Layouts: splits / stack / tall — cycle with `Ctrl+Shift+L`
- Tabs: powerline slanted, shown when 2+ open
- Scrollback: 10,000 lines

### Wofi (`config` + `scripts/`)
- Fuzzy case-insensitive, 450×320, centered, app icons 24px
- Power menu: Lock → Logout → Suspend → Reboot → Shutdown
- WiFi menu: scan + connect/disconnect via `nmcli`

### Fish (`config.fish` + `welcome.sh`)
- Minimal fast init
- Rich welcome script: OS, kernel, WM, uptime, memory

</details>

---

<details>
<summary><strong>🗃️ Supported Applications</strong> — 130+ pre-configured window rules</summary>

> [!NOTE]
> Not installed by setup.sh — only window rules are pre-configured. Install what you need.

- **Browsers:** Firefox, Zen Browser, Chrome, Chromium, Brave, LibreWolf, Vivaldi, Opera, Thorium
- **Terminals:** Kitty (+dropdown), Alacritty, Foot, Wezterm, Ghostty, Contour
- **File Managers:** Dolphin (10+ dialog rules), Nautilus, Thunar, PCManFM, Nemo, Caja, Krusader, Ranger
- **IDEs & Editors:** VSCode, VSCodium, all JetBrains IDEs, Android Studio, Zed, Neovide, Emacs, Sublime Text, Kate
- **Dev Tools:** DBeaver, TablePlus, Beekeeper, Insomnia, Postman, GitKraken, GitG, KiCad
- **Communication:** Discord/Vesktop/WebCord, Slack, Teams, Telegram, Signal, WhatsApp, Element, Fluffychat, Hexchat, Jami
- **Email:** Thunderbird, Betterbird, Evolution, KMail
- **Media:** Spotify/ncspot, VLC, MPV, Celluloid, Lollypop, Rhythmbox, Strawberry, Audacity, Haruna
- **Video Production:** OBS, Kdenlive, Openshot, Shotcut, DaVinci Resolve
- **Gaming:** Steam, Lutris, Heroic, Bottles, PrismLauncher, Minecraft, CS2, Valorant, Wine/Proton, MangoHUD, itch.io
- **Creative:** GIMP, Inkscape, Krita, Blender, Darktable, RawTherapee, Digikam
- **Office:** LibreOffice, OnlyOffice, WPS Office, Calibre, Evince, Okular, Zathura, Joplin
- **VMs & Remote:** Virt-Manager, VirtualBox, Remmina, Looking Glass, AnyDesk, RustDesk
- **System Tools:** Pavucontrol, GParted, Timeshift, Btop, Htop, KsysGuard, HardInfo, Baobab, Disks
- **CachyOS Specific:** CachyOS Hello, CachyOS Pi, BTRFS Assistant
- **KDE Utilities:** KDE Partition Manager, KTorrent, KStars, KCalc, KDE Connect, KDialog

</details>

---

## 🏷️ Topics

`cachyos` `cachyos-hyprland` `cachyos-dotfiles` `hyprland` `hyprland-dotfiles` `hyprland-config` `hyprland-theme` `wayland` `arch-linux` `tokyo-night` `ricing` `tiling-window-manager` `waybar` `wofi` `kitty` `linux` `desktop-setup` `cava` `fish-shell` `dunst` `scx-lavd` `eevdf` `performance` `gaming`
