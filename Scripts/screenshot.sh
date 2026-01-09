#!/usr/bin/env bash
# 🖼️ Screenshot Script using grimblast + satty

SAVE_DIR="$HOME/media/Screenshots"
mkdir -p "$SAVE_DIR"

MODE="${1:-area}" # Default to area if no arg
TIME=$(date +"%Y-%m-%d_%H-%M-%S")
FILE="$SAVE_DIR/screenshot_$TIME.png"

edit_and_copy() {
  satty --output-filename "$FILE" \
    --initial-tool brush \
    --copy-command wl-copy \
    --save-after-copy \
    --early-exit \
    --filename - && return 0 || return 1
}

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

# Only notify if file was actually saved
if [[ $? -eq 0 && -f "$FILE" ]]; then
  notify-send "📸 Screenshot saved!" "$FILE"
else
  notify-send "❌ Screenshot cancelled" -u low
fi
