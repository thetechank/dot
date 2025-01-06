#!/bin/bash

# Source and destination paths
SOURCE_DIR="$HOME"
DEST_DIR="$HOME/techspace/dot"

# Folders to copy
folders=(
    ".config/nvim"
    ".ankcmd"
    ".ankrc"
    ".vim"
)

# Create destination if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy files
echo "Copying dotfiles..."
for folder in "${folders[@]}"; do
    src="$SOURCE_DIR/$folder"
    dst="$DEST_DIR/$folder"
    
    if [ -e "$src" ]; then
        mkdir -p "$(dirname "$dst")"
        rsync -avh --delete "$src/" "$dst"
        echo "Copied: $folder"
    else
        echo "Warning: $folder not found in source"
    fi
done

# Git operations
cd "$DEST_DIR" || exit 1

# if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
#     echo "Initializing git repository..."
#     git init
# fi

echo "Adding files to git..."
git add .

echo "Committing changes..."
git commit -m "Update dotfiles: $(date '+%Y-%m-%d %H:%M:%S')"

echo "Pushing to remote..."
if git remote | grep -q "origin"; then
    git push origin main
else
    echo "No remote repository found. Please set up remote before pushing."
fi

echo "Done!"