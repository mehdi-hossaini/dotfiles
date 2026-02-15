## Install required packages (pacman)
    sudo pacman -S --needed \
    dunst \
    wofi \
    hyprpolkitagent \
    cachyos-gaming-meta \
    steam \
    hyprpaper \
    waybar
​

## Clone and copy configs
    git clone https://github.com/ViralScope/dotfiles.git
    cd dotfiles
    rm -rf .git
    cp hello.jpg "/home/$USER/Pictures/"
    cd .config
    mkdir -p "$HOME/.config"
    cp -r dunst hypr kitty wofi waybar "$HOME/.config/"
    reboot

## systemctl
    sudo systemctl status pci-latency.service
    echo "net.core.default_qdisc = cake" | sudo tee /etc/sysctl.d/99-cachy-networking.conf
    echo "net.ipv4.tcp_congestion_control = bbr" | sudo tee -a /etc/sysctl.d/99-cachy-networking.conf

## AstroNvim installation
    sudo pacman -S neovim 
    git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    nvim

## Keybinds​

| Key / Combo                   | Action                                      |
| ----------------------------- | ------------------------------------------- |
| SUPER + Enter                 | Open terminal (kitty)                       |
| SUPER + E                     | Open file manager (dolphin)                 |
| SUPER + Q                     | Close focused window                        |
| SUPER + F                     | Toggle fullscreen                           |
| SUPER + Shift + Space         | Toggle floating                             |
| SUPER + Shift + E             | Exit Hyprland                               |
| SUPER + ← / → / ↑ / ↓         | Focus window left / right / up / down       |
| SUPER + Shift + ← / → / ↑ / ↓ | Move window left / right / up / down        |
| SUPER + G                     | Toggle window group                         |
| Alt + Tab                     | Next window in group                        |
| Alt + Shift + Tab             | Previous window in group                    |
| SUPER + Ctrl + ← / → / ↑ / ↓  | Add window to group in given direction      |
| SUPER + Alt + ← / →           | Remove window from group in given direction |
| SUPER + Left Mouse            | Drag window                                 |
| SUPER + Right Mouse           | Resize window                               |
| SUPER + Scroll Down / Up      | Workspace next / previous                   |
| SUPER + 1–9,0                 | Switch to workspace 1–10                    |
| SUPER + Shift + 1–9,0         | Move window to workspace 1–10               |
| SUPER + Tab                   | Switch to last workspace                    |
| XF86AudioRaiseVolume          | Volume up (5%)                              |
| XF86AudioLowerVolume          | Volume down (5%)                            |
| XF86AudioMute                 | Toggle audio mute                           |
| XF86AudioMicMute              | Toggle mic mute                             |
| XF86AudioPlay / Pause         | Play / Pause                                |
| XF86AudioNext                 | Next track                                  |
| XF86AudioPrev                 | Previous track                              |
| XF86AudioStop                 | Stop playback                               |
| XF86MonBrightnessUp           | Brightness up (5%)                          |
| XF86MonBrightnessDown         | Brightness down (5%)                        |
| SUPER + D                     | Toggle Wofi (app launcher)                  |

