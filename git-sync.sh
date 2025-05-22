#!/bin/bash
# Git sync script for dotfiles
# Use this to pull/push changes to a remote repository

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

cd "$HOME/dotfiles" || { echo -e "${RED}Could not change to dotfiles directory${NC}"; exit 1; }

# Function to sync with git
git_sync() {
    local operation=$1
    
    # Check for uncommitted changes
    if [[ $(git status --porcelain) ]]; then
        echo -e "${YELLOW}Uncommitted changes detected${NC}"
        git status --short
        
        # Add all changes
        echo -e "${BLUE}Adding changes...${NC}"
        git add .
        
        # Commit changes
        echo -e "${BLUE}Committing changes...${NC}"
        git commit -m "Update dotfiles: $(date +%Y-%m-%d-%H%M)"
    else
        echo -e "${GREEN}No local changes to commit${NC}"
    fi
    
    # Perform requested operation
    if [[ $operation == "push" ]]; then
        echo -e "${BLUE}Pushing changes to remote repository...${NC}"
        if git push; then
            echo -e "${GREEN}Successfully pushed changes${NC}"
        else
            echo -e "${RED}Failed to push changes${NC}"
            exit 1
        fi
    elif [[ $operation == "pull" ]]; then
        echo -e "${BLUE}Pulling changes from remote repository...${NC}"
        if git pull; then
            echo -e "${GREEN}Successfully pulled changes${NC}"
            # Run symlink script to apply any pulled changes
            "$HOME/dotfiles/setup-symlinks.sh"
        else
            echo -e "${RED}Failed to pull changes${NC}"
            exit 1
        fi
    fi
}

# Check command line arguments
if [[ $1 == "push" ]]; then
    git_sync "push"
elif [[ $1 == "pull" ]]; then
    git_sync "pull"
else
    echo -e "${YELLOW}Usage:${NC} $(basename "$0") [push|pull]"
    echo "  push - Commit and push changes to remote repository"
    echo "  pull - Pull changes from remote repository and update symlinks"
    exit 1
fi

# Show notification
dunstify -u normal "Dotfiles" "Git sync complete" -i ~/.config/bspwm/src/assets/reload.svg 