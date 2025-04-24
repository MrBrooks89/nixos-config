# ~/.config/nixpkgs/hypr/hypr.nix
{ config, pkgs, ... }:

let
  # Define variables
  mainMod = "SUPER";
  terminal = "kitty";
  fileManager = "nautilus";
  menu = "rofi -show drun -show-icons";
  screenshotScript = "${config.home.homeDirectory}/.config/hypr/scripts/Screenshot.sh";
  wallpaperScript = "${config.home.homeDirectory}/.config/hypr/scripts/cycle_wallpapers.sh";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # Environment variables
      env = [
        "HYPRCURSOR_SIZE,32"
        "GTK_THEME,Dracula"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      ];

      # Monitor configuration
      monitor = [
        "DP-2, 1920x1080@144, 2560x0, 1"
        "DP-1, 2560x1440@85, 0x0, 1"
      ];

      # General settings
      general = {
        gaps_in = 6;
        gaps_out = 8;
        border_size = 2;
        col.active_border = "rgba(351c75ee) rgba(6a329fee) 45deg";
        col.inactive_border = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = false;
        allow_tearing = false;
      };

      # Decoration settings
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animation settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        special_scale_factor = 0.8;
      };

      # Master layout
      master = {
        new_status = "master";
        new_on_top = 1;
        mfact = 0.5;
      };

      # Misc settings
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
        focus_on_activate = false;
        initial_workspace_tracking = 0;
        middle_click_paste = false;
      };

      # Input configuration
      input = {
        kb_layout = "us";
        repeat_rate = 50;
        repeat_delay = 300;
        follow_mouse = 1;
        sensitivity = 0;
        numlock_by_default = true;
        touchpad.natural_scroll = false;
      };

      # Window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
      ];

      # Keybindings
      bind = [
        "${mainMod}, Return, exec, ${terminal}"
        "${mainMod}, Q, killactive"
        "${mainMod}, M, exit"
        "${mainMod}, T, exec, ${fileManager}"
        "${mainMod}, V, togglefloating"
        "${mainMod}, D, exec, ${menu}"
        "${mainMod}, P, pseudo"
        "${mainMod}, J, togglesplit"
        "${mainMod}, L, exec, swaylock --effect-blur 5x5 --clock --screenshots"
        "${mainMod} SHIFT, S, exec, ${screenshotScript}"
        "${mainMod}, B, exec, pkill waybar && waybar"

        # Workspace navigation
        "${mainMod}, 1, workspace, 1"
        "${mainMod}, 2, workspace, 2"
        "${mainMod}, 3, workspace, 3"
        "${mainMod}, 4, workspace, 4"
        "${mainMod}, 5, workspace, 5"
        "${mainMod}, 6, workspace, 6"
        "${mainMod}, 7, workspace, 7"
        "${mainMod}, 8, workspace, 8"
        "${mainMod}, 9, workspace, 9"
        "${mainMod}, 0, workspace, 10"

        # Move window to workspace
        "${mainMod} SHIFT, 1, movetoworkspace, 1"
        "${mainMod} SHIFT, 2, movetoworkspace, 2"
        "${mainMod} SHIFT, 3, movetoworkspace, 3"
        "${mainMod} SHIFT, 4, movetoworkspace, 4"
        "${mainMod} SHIFT, 5, movetoworkspace, 5"
        "${mainMod} SHIFT, 6, movetoworkspace, 6"
        "${mainMod} SHIFT, 7, movetoworkspace, 7"
        "${mainMod} SHIFT, 8, movetoworkspace, 8"
        "${mainMod} SHIFT, 9, movetoworkspace, 9"
        "${mainMod} SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "${mainMod}, mouse:272, movewindow"
        "${mainMod}, mouse:273, resizewindow"
      ];

      # Startup applications
      exec-once = [
        "waybar"
        "swww init"
        "bash ${wallpaperScript}"
      ];
    };
  };

  # Manage scripts
  home.file = {
    ".config/hypr/scripts/Screenshot.sh" = {
      executable = true;
      text = ''
        #!/bin/bash
        grim -g "$(slurp)" - | swappy -f -
      '';
    };

    ".config/hypr/scripts/cycle_wallpapers.sh" = {
      executable = true;
      text = ''
        #!/bin/bash
        swww init
        while true; do
          img=$(find "/home/mrbrooks/Pictures" -type f \( -name '*.jpg' -o -name '*.png' \) | shuf -n 1)
          [ -e "$img" ] && swww img "$img"
          sleep 300
        done
      '';
    };

    ".config/hypr/scripts/leave.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        choice=$(printf "Logout\nSuspend\nReboot\nShutdown" | rofi -dmenu)
        case $choice in
          "Logout") pkill -KILL -u "$USER" ;;
          "Suspend") systemctl suspend ;;
          "Reboot") systemctl reboot ;;
          "Shutdown") systemctl poweroff ;;
        esac
      '';
    };
  };
}
