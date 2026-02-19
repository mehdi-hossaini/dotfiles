#!/bin/bash
# Start Waybar and the tray watcher daemon.
# The watcher monitors D-Bus for new StatusNotifierItem registrations (apps
# going to the tray) and automatically restarts Waybar when one is detected.

# Kill any leftover instances
pkill -x waybar 2>/dev/null
pkill -f waybar-tray-watcher 2>/dev/null
sleep 0.3

# Start the tray watcher in the background
~/.config/hypr/scripts/waybar-tray-watcher.sh &

# Start Waybar
exec waybar
