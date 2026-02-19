#!/bin/bash
# Kitty Dropdown Terminal — Special Workspace (Scratchpad) Toggle

SCRATCHPAD="dropdown"
CLASS="kitty-dropdown"

# Get monitor dimensions dynamically (physical px → divide by scale for logical px)
MONITOR=$(hyprctl monitors -j | python3 -c "
import json,sys
m=json.load(sys.stdin)[0]
# logical dimensions account for HiDPI scale
lw = int(m['width'] / m['scale'])
lh = int(m['height'] / m['scale'])
print(lw, lh)
")
MON_W=$(echo $MONITOR | awk '{print $1}')
MON_H=$(echo $MONITOR | awk '{print $2}')

# Target size in logical pixels, centered horizontally, near top
WIN_W=800
WIN_H=500
POS_X=$(( (MON_W - WIN_W) / 2 ))
POS_Y=220

CLIENT_EXISTS=$(hyprctl clients -j | grep -c "\"$CLASS\"")

if [ "$CLIENT_EXISTS" -eq 0 ]; then
    # First launch: spawn kitty into the special workspace
    hyprctl dispatch exec "[workspace special:$SCRATCHPAD silent] kitty --class $CLASS"

    # Wait for the window to appear, then force size + position
    for i in $(seq 1 20); do
        sleep 0.1
        ADDR=$(hyprctl clients -j | python3 -c "
import json,sys
clients=json.load(sys.stdin)
match=[c for c in clients if c['class']=='$CLASS']
print(match[0]['address'] if match else '')
")
        if [ -n "$ADDR" ]; then
            hyprctl dispatch resizewindowpixel exact ${WIN_W} ${WIN_H},address:${ADDR}
            hyprctl dispatch movewindowpixel exact ${POS_X} ${POS_Y},address:${ADDR}
            break
        fi
    done

    # Show the special workspace
    hyprctl dispatch togglespecialworkspace "$SCRATCHPAD"
else
    hyprctl dispatch togglespecialworkspace "$SCRATCHPAD"
fi
