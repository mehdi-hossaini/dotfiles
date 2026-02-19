#!/bin/bash
# waybar-tray-watcher.sh
#
# Watches D-Bus for the FIRST StatusNotifierItem registration (i.e. the first
# app going to the system tray), restarts Waybar once, then exits.
#
# Launched automatically by waybar-start.sh via hyprland exec-once.

RESTART_DELAY=0.5   # seconds to wait before restarting waybar

echo "[tray-watcher] Waiting for first tray app..."

# Block until the very first RegisterStatusNotifierItem call appears on D-Bus,
# then break out immediately.
dbus-monitor --session \
    "type='method_call',interface='org.kde.StatusNotifierWatcher',member='RegisterStatusNotifierItem'" \
    2>/dev/null | \
while IFS= read -r line; do
    if echo "$line" | grep -q "RegisterStatusNotifierItem"; then
        echo "[tray-watcher] First tray app detected – restarting Waybar once."
        sleep "$RESTART_DELAY"
        pkill -x waybar
        sleep 0.3
        waybar &
        # Exit the watcher – job done.
        exit 0
    fi
done
