#!/bin/bash
# Symlink dotfiles to system
# Author: uylong

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to create symlinks
create_symlink() {
    local source_file="$1"
    local target_file="$2"
    
    # Create parent directories if they don't exist
    mkdir -p "$(dirname "$target_file")"
    
    # Check if target already exists
    if [ -e "$target_file" ]; then
        # If it's already a symlink pointing to our source, do nothing
        if [ -L "$target_file" ] && [ "$(readlink "$target_file")" == "$source_file" ]; then
            echo -e "${BLUE}Link already exists:${NC} $target_file -> $source_file"
            return 0
        fi
        
        # Backup existing file/directory
        local backup_file="${target_file}.backup.$(date +%Y%m%d-%H%M%S)"
        echo -e "${YELLOW}Backing up:${NC} $target_file -> $backup_file"
        mv "$target_file" "$backup_file"
    fi
    
    # Create symlink
    echo -e "${GREEN}Creating symlink:${NC} $target_file -> $source_file"
    ln -s "$source_file" "$target_file"
}

# Setup Config directory symlinks
echo -e "${BLUE}Setting up config symlinks...${NC}"
for config_dir in "$HOME/dotfiles/config/"*/; do
    dir_name=$(basename "$config_dir")
    create_symlink "$HOME/dotfiles/config/$dir_name" "$HOME/.config/$dir_name"
done

# Setup home directory dotfiles
echo -e "${BLUE}Setting up home dotfiles...${NC}"
for dotfile in "$HOME/dotfiles/home/".*; do
    # Skip . and .. directories
    if [[ "$dotfile" == "$HOME/dotfiles/home/." || "$dotfile" == "$HOME/dotfiles/home/.." ]]; then
        continue
    fi
    
    file_name=$(basename "$dotfile")
    create_symlink "$dotfile" "$HOME/$file_name"
done

# Set up misc files if needed
echo -e "${BLUE}Setting up misc files...${NC}"
# Example: Set up local bin files
mkdir -p "$HOME/.local/bin"
for bin_file in "$HOME/dotfiles/misc/bin/"*; do
    if [ -f "$bin_file" ]; then
        file_name=$(basename "$bin_file")
        create_symlink "$bin_file" "$HOME/.local/bin/$file_name"
    fi
done

# Make sure the script is executable
chmod +x "$HOME/.local/bin/"*

echo -e "${GREEN}Done! Your dotfiles are now symlinked.${NC}"
echo -e "${YELLOW}Note:${NC} You may need to restart applications for changes to take effect." 