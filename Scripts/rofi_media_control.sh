#!/bin/bash

# --- Fetch Metadata ---
ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)
STATUS=$(playerctl status 2>/dev/null)

# --- Set Status Icons and Text ---
if [ "$STATUS" == "Playing" ]; then
  STATUS_ICON="▶"
  PLAY_PAUSE_TEXT="⏸ Pause"
elif [ "$STATUS" == "Paused" ]; then
  STATUS_ICON="⏸"
  PLAY_PAUSE_TEXT="▶ Play"
else
  notify-send "No media player active." -t 3000
  exit 0
fi

# --- Rofi Menu Title ---
INFO="$STATUS_ICON $TITLE by $ARTIST"

# --- Rofi Menu Options ---
OPTIONS="$PLAY_PAUSE_TEXT\n⏮ Previous\n⏭ Next"

# --- Run Rofi ---
ACTION=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "$INFO" -width 30 -lines 3)

# --- Execute Action Based on Selection ---
case "$ACTION" in
*"Pause"*) playerctl pause ;;
*"Play"*) playerctl play ;;
*"Previous"*) playerctl previous ;;
*"Next"*) playerctl next ;;
esac
