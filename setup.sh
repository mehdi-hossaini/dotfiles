#!/usr/bin/env bash
set -e

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
    wl-clipboard

echo "== Cloning dotfiles =="

REPO_DIR="$HOME/dotfiles"

if [ ! -d "$REPO_DIR" ]; then
    git clone https://github.com/ViralScope/dotfiles.git "$REPO_DIR"
else
    echo "Dotfiles already exist. Pulling latest changes..."
    git -C "$REPO_DIR" pull || true
fi

mkdir -p "$HOME/Pictures"
cp -f "$REPO_DIR/hello.jpg" "$HOME/Pictures/" 2>/dev/null || true

mkdir -p "$HOME/.config"

# Ask user which version to install
echo ""
echo "Choose dotfiles version:"
echo "1) Stable (default)"
echo "2) Experimental"
read -p "Enter choice [1/2] (default: 1): " choice
choice=${choice:-1}

if [ "$choice" = "2" ]; then
    echo "Installing experimental dotfiles..."
    CONFIG_SOURCE="$REPO_DIR/experimental"
    DIRS="btop dunst fish hypr kitty waybar wofi"
else
    echo "Installing stable dotfiles..."
    CONFIG_SOURCE="$REPO_DIR/.config"
    DIRS="dunst hypr kitty wofi waybar"
fi

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

# Set permissions and run scripts for experimental version
if [ "$choice" = "2" ]; then
    echo "== Setting executable permissions for experimental scripts =="
    chmod +x "$HOME/.config/fish/welcome.sh" 2>/dev/null || echo "Warning: fish/welcome.sh not found"
    chmod +x "$HOME/.config/hypr/scripts/kde-dark-mode.sh" 2>/dev/null || echo "Warning: kde-dark-mode.sh not found"
    chmod +x "$HOME/.config/hypr/scripts/kitty-dropdown.sh" 2>/dev/null || echo "Warning: kitty-dropdown.sh not found"

    echo "== Running KDE dark mode script =="
    if [ -f "$HOME/.config/hypr/scripts/kde-dark-mode.sh" ]; then
        "$HOME/.config/hypr/scripts/kde-dark-mode.sh"
        echo "KDE dark mode applied"
    else
        echo "Warning: kde-dark-mode.sh not found, skipping"
    fi
fi

echo "== Setup Complete =="
echo "Reboot recommended."
