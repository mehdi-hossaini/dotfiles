#!/usr/bin/env bash
set -e


echo "== Updating mirror list =="
sudo cachyos-rate-mirrors


echo "== System upgrade =="
sudo pacman -Syu --noconfirm


echo "== Installing packages =="
sudo pacman -S --needed --noconfirm \
    hyprland \
    kitty \
    dolphin \
    dunst \
    hyprpaper \
    waybar \
    wofi \
    polkit-kde-agent \
    brightnessctl \
    playerctl \
    pipewire \
    pipewire-pulse \
    wireplumber \
    hicolor-icon-theme \
    qt5-wayland \
    qt6-wayland \
    xdg-desktop-portal-hyprland \
    ttf-jetbrains-mono-nerd \
    cachyos-gaming-meta \
    steam \
    grim \
    slurp \
    wl-clipboard \
    cava


echo "== Cloning dotfiles =="


REPO_DIR="$HOME/dotfiles"


if [ ! -d "$REPO_DIR" ]; then
    git clone https://github.com/mehdi-hossaini/dotfiles.git "$REPO_DIR"
else
    echo "Dotfiles already exist. Pulling latest changes..."
    git -C "$REPO_DIR" pull || true
fi


mkdir -p "$HOME/Pictures"
cp -f "$REPO_DIR/hello.jpg" "$HOME/Pictures/" 2>/dev/null || true


mkdir -p "$HOME/.config"


echo "Installing experimental dotfiles..."
CONFIG_SOURCE="$REPO_DIR/experimental"
DIRS="btop dunst fish hypr kitty waybar wofi"


if [ -d "$CONFIG_SOURCE" ]; then
    for dir in $DIRS; do
        if [ -d "$CONFIG_SOURCE/$dir" ]; then
            cp -r "$CONFIG_SOURCE/$dir" "$HOME/.config/"
            echo "Copied $dir"
        else
            echo "Skipped $dir (not found in repo)"
        fi
    done
else
    echo "Config directory not found in repository."
fi


echo "== Enabling BBR + CAKE sysctl config =="
sudo tee /etc/sysctl.d/99-cachy-networking.conf > /dev/null <<EOF
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr
EOF


sudo sysctl --system


echo "== Disabling ananicy-cpp =="
sudo systemctl disable --now ananicy-cpp || true


echo "== Applying CAKE to active interface =="
IFACE=$(ip route | awk '/default/ {print $5}' | head -n1)
if [ -n "$IFACE" ]; then
    sudo tc qdisc replace dev "$IFACE" root cake || true
    echo "Applied CAKE on $IFACE"
else
    echo "Could not detect active interface."
fi


echo "== Activating ADIOS on NVMe drives (if supported) =="


for dev in /sys/block/nvme*n*; do
    if [ -f "$dev/queue/scheduler" ]; then
        if grep -q adios "$dev/queue/scheduler"; then
            echo adios | sudo tee "$dev/queue/scheduler"
            echo "ADIOS set on $(basename $dev)"
        else
            echo "ADIOS not available on $(basename $dev)"
        fi
    fi
done


echo "== Making ADIOS persistent via udev rule =="


sudo tee /etc/udev/rules.d/60-ioschedulers.rules > /dev/null <<EOF
ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="nvme[0-9]*n[0-9]*", ATTR{queue/scheduler}="adios"
EOF


sudo udevadm control --reload-rules
sudo udevadm trigger


echo "== Setting executable permissions for scripts =="
chmod +x "$HOME/.config/fish/welcome.sh" 2>/dev/null || echo "Warning: fish/welcome.sh not found"
chmod +x "$HOME/.config/hypr/scripts/kde-dark-mode.sh" 2>/dev/null || echo "Warning: kde-dark-mode.sh not found"
chmod +x "$HOME/.config/hypr/scripts/kitty-dropdown.sh" 2>/dev/null || echo "Warning: kitty-dropdown.sh not found"
chmod +x "$HOME/.config/hypr/scripts/waybar-start.sh" 2>/dev/null || echo "Warning: waybar-start.sh not found"
chmod +x "$HOME/.config/hypr/scripts/waybar-tray-watcher.sh" 2>/dev/null || echo "Warning: waybar-tray-watcher.sh not found"
chmod +x "$HOME/.config/wofi/scripts/power.sh" 2>/dev/null || echo "Warning: wofi/scripts/power.sh not found"
chmod +x "$HOME/.config/wofi/scripts/wifi.sh" 2>/dev/null || echo "Warning: wofi/scripts/wifi.sh not found"
chmod +x "$HOME/.config/waybar/scripts/cava.sh" 2>/dev/null || echo "Warning: waybar/scripts/cava.sh not found"


echo "== Running KDE dark mode script =="
if [ -f "$HOME/.config/hypr/scripts/kde-dark-mode.sh" ]; then
    "$HOME/.config/hypr/scripts/kde-dark-mode.sh"
    echo "KDE dark mode applied"
else
    echo "Warning: kde-dark-mode.sh not found, skipping"
fi


echo "== Setup Complete =="
echo "Reboot recommended."
echo ""
cat <<EOF
=======================================================
  POST-SETUP CONFIGURATION
=======================================================

Before logging into Hyprland, review the following:

  1. AUTO-DETECT MONITOR
     Let Hyprland automatically pick the best resolution
     and refresh rate for your display:

       sed -i 's/^monitor = .*/monitor = , preferred, auto, auto/' \\
           ~/.config/hypr/hyprland.conf

  2. SET KEYBOARD LAYOUT
     The default layout is set to 'se' (Swedish).
     Replace it with your own layout code if needed:

       sed -i 's/kb_layout = se/kb_layout = us/' \\
           ~/.config/hypr/hyprland.conf

     Common layout codes:
       us  - English (US)
       gb  - English (UK)
       de  - German
       fr  - French
       es  - Spanish

=======================================================
EOF
