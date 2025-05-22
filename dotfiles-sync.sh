#!/bin/bash
# Dotfiles Sync Script
# This script will reload services after dotfiles changes

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Syncing dotfiles changes...${NC}"

# Re-run symlink script to ensure all links are up to date
"$HOME/dotfiles/setup-symlinks.sh"

# Reload BSPWM
echo -e "${YELLOW}Reloading BSPWM...${NC}"
bspc wm -r

# Show notification
dunstify -u normal "Dotfiles" "Configuration synced and reloaded" -i ~/.config/bspwm/src/assets/reload.svg

echo -e "${GREEN}Sync complete!${NC}" 