#!/bin/bash

# Define the driver and notification tool
DRIVER="uvcvideo"
NOTIFY="notify-send"
NOTIFY_TITLE="Webcam Toggler"

# Check if the module is currently loaded
if lsmod | grep -q "$DRIVER"; then
  # Module is loaded -> Unload (Disable)
  # The '2>/dev/null' suppresses any error messages if the module is busy
  sudo modprobe -r "$DRIVER" 2>/dev/null
  $NOTIFY "$NOTIFY_TITLE" "Webcam has been **DISABLED**."
else
  # Module is not loaded -> Load (Enable)
  sudo modprobe "$DRIVER"
  $NOTIFY "$NOTIFY_TITLE" "Webcam has been **ENABLED**."
fi
