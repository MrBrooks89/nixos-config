#!/bin/bash

# Wait for DP-1 to appear
while ! hyprctl monitors | grep -q "DP-1"; do
  sleep 1
done

# Wait for DP-2 to appear
while ! hyprctl monitors | grep -q "DP-2"; do
  sleep 1
done

# Run the wallpaper command
/usr/bin/linux-wallpaperengine \
  --screen-root DP-1 3373621687 \
  --screen-root DP-2 3373621687 


