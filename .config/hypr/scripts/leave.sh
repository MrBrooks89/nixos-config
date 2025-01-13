#!/usr/bin/env bash

# Display options in the Rofi menu
choice=$(printf "Logout\nSuspend\nReboot\nShutdown" | rofi -dmenu)

# Check the chosen option
case $choice in
    "Logout")
        # Logout the current user
        pkill -KILL -u "$USER"
        ;;
    "Suspend")
        # Suspend the system
        systemctl suspend
        ;;
    "Reboot")
        # Reboot the system
        systemctl reboot
        ;;
    "Shutdown")
        # Shutdown the system
        systemctl poweroff
        ;;
esac
