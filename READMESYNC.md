# Symlink-Based Dotfiles Management

This repository contains my personal dotfiles for my Linux environment, with a symlink-based management system for easy synchronization across multiple machines.

![Screenshot](https://github.com/gh0stzk/dotfiles/assets/67278339/0340846a-74d4-4a43-9430-142b0832738d)

## Setup

This dotfiles repository uses a symlink-based management system:
- Files in the repository are linked to their appropriate locations in the system
- Changes can be made directly in the repository and applied with a single command/keystroke
- Git integration allows for easy syncing between multiple machines

## Usage Instructions

### Initial Setup

When setting up a new machine:

```bash
# Clone the repository
git clone [your-repo-url] ~/dotfiles

# Make scripts executable
chmod +x ~/dotfiles/setup-symlinks.sh ~/dotfiles/dotfiles-sync.sh ~/dotfiles/git-sync.sh

# Create symlinks to your system
cd ~/dotfiles
./setup-symlinks.sh
```

### Daily Workflow

1. **Make Changes**:
   - Edit files directly in the `~/dotfiles` directory
   - Changes are made to the repository, not directly to your system files

2. **Apply Changes**:
   - Press `Ctrl+Super+Alt+D` (keyboard shortcut)
   - Or run: `~/dotfiles/dotfiles-sync.sh`
   - This updates symlinks and reloads BSPWM

3. **Sync Between Machines**:
   - Push changes: `~/dotfiles/git-sync.sh push`
   - Pull on another machine: `~/dotfiles/git-sync.sh pull`

### Repository Structure

```
~/dotfiles/
├── config/        # -> ~/.config/
│   ├── bspwm/     # Window manager configuration
│   ├── nvim/      # Neovim configuration
│   └── ...        # Other XDG config directories
├── home/          # Traditional dotfiles for home directory
│   ├── .zshrc     # -> ~/.zshrc
│   └── ...        # Other dotfiles
├── misc/          # Miscellaneous files
│   └── bin/       # -> ~/.local/bin/
├── setup-symlinks.sh   # Creates symlinks to system locations
├── dotfiles-sync.sh    # Syncs changes and reloads the environment
└── git-sync.sh         # Handles git operations for syncing
```

### Available Scripts

1. **setup-symlinks.sh**:
   - Creates symbolic links from repository files to system locations
   - Backs up existing files before creating links
   - Only needs to be run once per machine or when adding new files

2. **dotfiles-sync.sh**:
   - Re-runs the symlink script to ensure all links are up-to-date
   - Reloads BSPWM to apply changes
   - Bound to keyboard shortcut `Ctrl+Super+Alt+D`

3. **git-sync.sh**:
   - Handles git operations for syncing between machines
   - Usage: `./git-sync.sh push` or `./git-sync.sh pull`
   - Automatically commits and pushes/pulls changes

## Keybindings

Added keybinding for dotfiles management:
- `Ctrl+Super+Alt+D`: Run dotfiles-sync.sh to apply changes

## Original Dotfiles Information

These dotfiles are based on the gh0stzk dotfiles collection, a complete BSPWM Window Manager Environment. For information about the original themes, features, and installation, see below.

---

# A complete BSPWM Window Manager Environment

[Original README content continues...] 