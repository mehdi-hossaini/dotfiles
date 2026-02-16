#!/bin/bash
# Kitty Dropdown Terminal Toggle Script

# Check if dropdown window exists (using hyprctl)
DROPDOWN_EXISTS=$(hyprctl clients | grep -c "kitty-dropdown")

if [ "$DROPDOWN_EXISTS" -gt 0 ]; then
    # Close existing dropdown
    hyprctl dispatch killactive
else
    # Launch new dropdown
    kitty --class kitty-dropdown &
fi
