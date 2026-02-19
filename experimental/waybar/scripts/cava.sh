#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# CONFIGURATION
# -----------------------------------------------------------------------------
# VISUAL_STYLE: "blocks" (classic) or "braille" (modern/minimalist)
VISUAL_STYLE="blocks" 

# BAR_WIDTH: Number of bars to display (adjust based on your bar width)
BAR_WIDTH=12

# -----------------------------------------------------------------------------
# INTERNAL SETUP
# -----------------------------------------------------------------------------
# Create a secure temporary config file
CONFIG_FILE=$(mktemp /tmp/cava_config.XXXXXX)

# Cleanup function to run when the script is stopped (killed or exits)
cleanup() {
    rm -f "$CONFIG_FILE"
    # Killing the process group ensures no orphaned cava instances
    if [ -n "${CAVA_PID-}" ]; then
        kill "$CAVA_PID" 2>/dev/null || true
    fi
}
trap cleanup EXIT INT TERM

# -----------------------------------------------------------------------------
# CAVA CONFIG GENERATION
# -----------------------------------------------------------------------------
# We tune 'gravity' and 'integral' for a visually pleasing "dance"
cat <<EOF > "$CONFIG_FILE"
[general]
bars = $BAR_WIDTH
framerate = 60
sleep_timer = 5

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[smoothing]
monstercat = 1
waves = 0
noise_reduction = 0.77
integral = 77
gravity = 100
EOF

# -----------------------------------------------------------------------------
# VISUAL DICTIONARIES
# -----------------------------------------------------------------------------
if [ "$VISUAL_STYLE" == "braille" ]; then
    # Braille pattern (Empty, dots rising)
    DICT="s/0/⠀/g;s/1/⡀/g;s/2/⣀/g;s/3/⣄/g;s/4/⣤/g;s/5/⣦/g;s/6/⣶/g;s/7/⣷/g;"
else
    # Classic Blocks (Space, then rising blocks)
    DICT="s/0/ /g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;"
fi

# -----------------------------------------------------------------------------
# EXECUTION PIPELINE
# -----------------------------------------------------------------------------
# 1. stdbuf -oL: Forces line buffering so updates happen instantly
# 2. sed -u: Unbuffered stream editing for low latency
# 3. The sed logic removes semicolons and maps numbers to icons

cava -p "$CONFIG_FILE" | \
    sed -u "$DICT s/;//g"