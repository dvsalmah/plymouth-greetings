#!/bin/bash
set -euo pipefail

MODE="${1:-boot}"
DURATION="${2:-6}"
THEME_DIR="/usr/share/plymouth/themes/plymouth-greetings"

trap 'sudo plymouth quit 2>/dev/null || true' EXIT INT TERM

sudo mkdir -p "$THEME_DIR"
sudo cp assets/hello/*.png assets/goodbye/*.png theme.script "$THEME_DIR/" 2>/dev/null || true

echo "Testing $MODE theme for ${DURATION}s (Ctrl+C to cancel)..."
sudo plymouthd --mode="$MODE"
sudo plymouth --show-splash
sleep "$DURATION"
