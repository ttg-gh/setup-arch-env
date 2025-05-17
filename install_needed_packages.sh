#!/bin/bash

sudo pacman -Syyu

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

yay -Syyu

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
    interception-caps2esc
    interception-tools
    fzf
    tmux
    ranger
    wl-clipboard
    unzip
)

# Define AUR packages
AUR_PKGS=(
    librewolf-bin
    kime-bin
    starship
    hyprshot
)

# Update system and install official packages
echo "Installing official packages..."
sudo pacman -Syu --noconfirm "${PACMAN_PKGS[@]}"

# Install AUR packages
echo "Installing AUR packages..."
yay -S --noconfirm "${AUR_PKGS[@]}"

git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim

echo "Creating /etc/interception/udevmon.d/ directory..."
sudo mkdir -p /etc/interception/udevmon.d/

sudo tee /etc/interception/udevmon.d/caps2esc.yml > /dev/null <<EOF
- JOB: intercept -g \$DEVNODE | caps2esc | uinput -d \$DEVNODE
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
EOF
systemctl enable udevmon.service
systemctl start udevmon.service

sudo systemctl enable ly.service
sudo systemctl start ly.service 
