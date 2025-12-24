#!/usr/bin/env bash

# 🖼️ Screenshot Script using grimblast + satty
# Supports: area, full, window

# Save directory
SAVE_DIR="$HOME/media/Screenshots"
mkdir -p "$SAVE_DIR"

# Mode from argument (area|full|window)
MODE="$1"

# Generate timestamp filename
TIME=$(date +"%Y-%m-%d_%H-%M-%S")
FILE="$SAVE_DIR/screenshot_$TIME.png"

# Function to edit and copy the screenshot with Satty
edit_and_copy() {
  satty --output-filename "$FILE" \
    --initial-tool brush \
    --copy-command wl-copy \
    --save-after-copy \
    --early-exit \
    --filename -
}

# Choose what to capture
case "$MODE" in
area)
  grimblast save area - | edit_and_copy
  ;;
full)
  grimblast save output - | edit_and_copy
  ;;
window)
  grimblast save active - | edit_and_copy
  ;;
*)
  echo "Usage: $0 {area|full|window}"
  exit 1
  ;;
esac

# Optional desktop notification
notify-send "📸 Screenshot saved!" "$FILE"
