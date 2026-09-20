#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

THEME_NAME="plymouth-greetings"
TARGET_DIR="/usr/share/plymouth/themes/$THEME_NAME"

sudo -v

log_step() {
    local percent=$1
    local text=$2
    printf "\033[1;37m[%3d%%]\033[0m %s\n" "$percent" "$text"
}

log_step 20 "Preparing directory..."
sudo rm -rf "$TARGET_DIR"
sudo mkdir -p "$TARGET_DIR"

log_step 45 "Copying assets and script..."
sudo cp assets/hello/*.png assets/goodbye/*.png theme.script "$TARGET_DIR/" 2>/dev/null || true
sudo cp theme.plymouth "$TARGET_DIR/$THEME_NAME.plymouth" 2>/dev/null || true

log_step 65 "Setting permissions..."
sudo chmod 755 "$TARGET_DIR"
sudo chmod 644 "$TARGET_DIR"/* 2>/dev/null || true

log_step 80 "Setting default theme..."
sudo plymouth-set-default-theme "$THEME_NAME" >/dev/null 2>&1 || true

if command -v mkinitcpio >/dev/null 2>&1; then
    log_step 90 "Rebuilding initramfs with mkinitcpio..."
    sudo mkinitcpio -P >/dev/null 2>&1
elif command -v dracut >/dev/null 2>&1; then
    log_step 90 "Rebuilding initramfs with dracut..."
    sudo dracut -f >/dev/null 2>&1
elif command -v update-initramfs >/dev/null 2>&1; then
    log_step 90 "Rebuilding initramfs with update-initramfs..."
    sudo update-initramfs -u >/dev/null 2>&1
else
    log_step 90 "No initramfs rebuild tool found; skipping rebuild."
fi

log_step 100 "Done! Theme installed properly."
