#!/bin/bash

# Prompt for GitHub repo URL
read -p "Enter GitHub repository URL (e.g., https://github.com/user/repo.git): " repo_url

# Extract repo name from URL
repo_name=$(basename -s .git "$repo_url")
sudo pacman -Syyu
sudo pacman -Syu git
cd
# Clone the repository
git clone "$repo_url"

# Check if clone was successful
if [ $? -eq 0 ]; then
    echo "Successfully cloned $repo_name"
    cd "$repo_name" || { echo "Failed to enter directory $repo_name"; exit 1; }
    echo "Now in directory: $(pwd)"
else
    echo "Failed to clone repository"
    exit 1
fi

rm -rf .bashrc
rm -rf .config

sudo pacman -Syu stow
for dir in */; do
	stow "${dir%/}"
done
cd
