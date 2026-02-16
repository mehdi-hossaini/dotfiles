#!/bin/bash
# Ultimate Dolphin Dark Mode Fix - KDE Platform Theme Method

echo "============================================"
echo "Dolphin Dark Mode - KDE Platform Method"
echo "============================================"

# Step 1: Install packages
echo ""
echo "[1/4] Installing packages..."
sudo pacman -S --needed plasma-integration breeze breeze-icons

# Step 2: Create directories
echo ""
echo "[2/4] Creating directories..."
mkdir -p ~/.config
mkdir -p ~/.local/share/color-schemes
mkdir -p ~/.local/share/plasma

# Remove if directory exists
[ -d ~/.config/kdeglobals ] && rm -rf ~/.config/kdeglobals

# Step 3: Create KDE config with full color palette
echo ""
echo "[3/4] Configuring KDE theme..."

cat > ~/.config/kdeglobals << 'EOF'
[ColorEffects:Disabled]
Color=56,56,56
ColorAmount=0
ColorEffect=0
ContrastAmount=0.65
ContrastEffect=1
IntensityAmount=0.1
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=112,111,110
ColorAmount=0.025
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=2
Enable=false
IntensityAmount=0
IntensityEffect=0

[Colors:Button]
BackgroundAlternate=30,87,116
BackgroundNormal=49,54,59
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Complementary]
BackgroundAlternate=30,87,116
BackgroundNormal=42,46,50
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Header]
BackgroundAlternate=42,46,50
BackgroundNormal=49,54,59
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Selection]
BackgroundAlternate=30,87,116
BackgroundNormal=61,174,233
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=252,252,252
ForegroundInactive=161,169,177
ForegroundLink=253,188,75
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=252,252,252
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Tooltip]
BackgroundAlternate=42,46,50
BackgroundNormal=49,54,59
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:View]
BackgroundAlternate=35,38,41
BackgroundNormal=27,30,32
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Window]
BackgroundAlternate=49,54,59
BackgroundNormal=42,46,50
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[General]
ColorScheme=BreezeDark
Name=Breeze Dark
XftAntialias=true
XftHintStyle=hintslight
XftSubPixel=rgb

[Icons]
Theme=breeze-dark

[KDE]
LookAndFeelPackage=org.kde.breezedark.desktop
EOF

# Step 4: Create BreezeDark color scheme file
echo ""
echo "[4/4] Creating color scheme file..."

cat > ~/.local/share/color-schemes/BreezeDark.colors << 'EOF'
[ColorEffects:Disabled]
Color=56,56,56
ColorAmount=0
ColorEffect=0
ContrastAmount=0.65
ContrastEffect=1
IntensityAmount=0.1
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=112,111,110
ColorAmount=0.025
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=2
Enable=false
IntensityAmount=0
IntensityEffect=0

[Colors:Button]
BackgroundAlternate=30,87,116
BackgroundNormal=49,54,59
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Complementary]
BackgroundAlternate=30,87,116
BackgroundNormal=42,46,50
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Header]
BackgroundAlternate=42,46,50
BackgroundNormal=49,54,59
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Selection]
BackgroundAlternate=30,87,116
BackgroundNormal=61,174,233
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=252,252,252
ForegroundInactive=161,169,177
ForegroundLink=253,188,75
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=252,252,252
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Tooltip]
BackgroundAlternate=42,46,50
BackgroundNormal=49,54,59
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:View]
BackgroundAlternate=35,38,41
BackgroundNormal=27,30,32
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[Colors:Window]
BackgroundAlternate=49,54,59
BackgroundNormal=42,46,50
DecorationFocus=61,174,233
DecorationHover=61,174,233
ForegroundActive=61,174,233
ForegroundInactive=161,169,177
ForegroundLink=29,153,243
ForegroundNegative=218,68,83
ForegroundNeutral=246,116,0
ForegroundNormal=239,240,241
ForegroundPositive=39,174,96
ForegroundVisited=155,89,182

[General]
ColorScheme=BreezeDark
Name=Breeze Dark

[KDE]
LookAndFeelPackage=org.kde.breezedark.desktop
EOF

echo ""
echo "============================================"
echo "✓ Configuration complete!"
echo ""
echo "Add these lines to hyprland.conf:"
echo ""
echo "    env = QT_QPA_PLATFORMTHEME,kde"
echo ""
echo "Then LOG OUT and LOG BACK IN"
echo ""
echo "Test now: QT_QPA_PLATFORMTHEME=kde dolphin"
echo "============================================"
