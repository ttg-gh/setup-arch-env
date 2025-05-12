#!/bin/bash

cd ~
echo "Installing yay..."

# Install prerequisites for building AUR packages
sudo pacman -S --needed git base-devel

# Clone and install yay
if [ ! -d yay ]; then
    git clone https://aur.archlinux.org/yay.git
fi
cd yay
makepkg -si
cd ~

# Define official repository packages (proper array syntax)
PACMAN_PKGS=(
    foot
    hyprland
    ly
    neovim
    pavucontrol
    rofi
    ttf-firacode-nerd
    waybar
    mako
    hyprpaper
    neofetch
    starship
    caps2esc
)

# Define AUR packages
AUR_PKGS=(
    librewolf-bin
    kime-bin
)

# Update system and install official packages
echo "Installing official packages..."
sudo pacman -Syu --noconfirm "${PACMAN_PKGS[@]}"

# Install AUR packages
echo "Installing AUR packages..."
yay -S --noconfirm "${AUR_PKGS[@]}"
