#!/bin/bash

# Configuration
CONFIG_ITEMS=(
    "$HOME/.bashrc"
    "$HOME/.gitconfig"
    "$HOME/.kube/config"
    "$HOME/.kube/grofers-k8s-config"
    "$HOME/.config/kafkactl/*"
    "$HOME/.config/gh/*"
    "$HOME/.config/iterm2/*"
    "$HOME/.zshrc"
    "$HOME/.zsh*"
    "$HOME/.ssh/*"
    "$HOME/.aws/"
)

BACKUP_DIR="$HOME/config-files"
GITHUB_REPO_URL="git@github.com:rishav394/config-files.git"
BRANCH="main" # Change to your target branch if needed
COMMIT_MESSAGE="Backup config files and directories on $(date)"

# Function to display error and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Make sure rsync protocol is greater than 30
# If not install rsync using brew
# sudo ln -s /opt/homebrew/bin/rsync /usr/local/bin/rsync

# Step 1: Create backup directory
mkdir -p "$BACKUP_DIR" || error_exit "Failed to create backup directory"

# Step 2: Copy files and directories to backup directory
for item in "${CONFIG_ITEMS[@]}"; do
    expanded_items=($item)
    for expanded_item in "${expanded_items[@]}"; do
        if [[ -e "$expanded_item" ]]; then
            # Use rsync for better handling of directories
            /opt/homebrew/bin/rsync -a --relative --mkpath "$expanded_item" "$BACKUP_DIR" || error_exit "Failed to copy $expanded_item"
        else
            echo "Warning: $expanded_item not found, skipping"
        fi
    done
done

# Step 3: Navigate to backup directory
cd "$BACKUP_DIR" || error_exit "Failed to navigate to backup directory"

# Step 4: Initialize Git repository if not already initialized
if [[ ! -d .git ]]; then
    git init || error_exit "Failed to initialize Git repository"
    git remote add origin "$GITHUB_REPO_URL" || error_exit "Failed to set remote repository"
fi

# Step 5: Pull latest changes
git fetch origin "$BRANCH" || error_exit "Failed to fetch branch $BRANCH"
git checkout "$BRANCH" || git checkout -b "$BRANCH" || error_exit "Failed to switch to branch $BRANCH"

# Step 6: Add and commit changes
git add . || error_exit "Failed to stage changes"
git commit -nm "$COMMIT_MESSAGE" || error_exit "Failed to commit changes"

# Step 7: Push changes
# git push origin "$BRANCH" || error_exit "Failed to push changes"

echo "Backup completed successfully!"