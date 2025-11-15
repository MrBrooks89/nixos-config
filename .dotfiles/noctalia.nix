{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # Install Noctalia package
  home.packages = [inputs.noctalia.packages.${pkgs.system}.default];

  # Enable and configure Noctalia Shell
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # Bar configuration
      bar = {
        position = "top";
        density = "default";
        widgets = {
          left = [
            {id = "SystemMonitor";}

            {id = "AcitveWindow";}

            {id = "MediaMini";}
          ];
          center = [
            {
              id = "Workspace";
              characterCount = 2;
            }
          ];
          right = [
            {id = "Tray";}
            {id = "ScreenRecorder";}
            {id = "Volume";}
            {id = "Brightness";}
            {id = "Network";}
            {id = "Clock";}
            {id = "ControlCenter";}
          ];
        };
      };

      # General settings
      general = {
        # Avatar path (optional)
        # avatar = "/path/to/avatar.png";
        radiusRatio = 0.5;
        animSpeed = 200;
        animDisabled = false;
        lockBehavior = "blur";
        language = "en";
      };

      # Location and time settings
      location = {
        name = "Longview, USA";
        weatherEnabled = true;
        useFahrenheit = true;
        use12hourFormat = true;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
      };
      screenRecorder = {
        directory = "/home/mrbrooks/Videos/ScreenRecordings";
        frameRate = 60;
        audioCodec = "aac";
        videoCodec = "h264";
        quality = "very_high";
        colorRange = "limited";
        showCursor = true;
        audioSource = "default_output";
        videoSource = "portal";
      };
      wallpaper = {
        enabled = true;
        directory = "/home/mrbrooks/Pictures/Wallpapers";
        enableMultiMonitorDirectories = false;
        setWallpaperOnAllMonitors = true;
        defaultWallpaper = "/home/mrbrooks/Pictures/Wallpapers/1234448.jpg";
        fillMode = "crop";
        fillColor = "#000000";
        randomEnabled = true;
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        monitors = [];
      };
      appLauncher = {
        enableClipboardHistory = false;
        position = "center";
        backgroundOpacity = 1;
        pinnedExecs = [];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
      };
      controlCenter = {
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "ScreenRecorder";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      dock = {
        displayMode = "AutoHide";
        backgroundOpacity = 0;
        floatingRatio = 0;
        onlySameOutput = false;
        monitors = ["HDMI-A-1"];
        pinnedApps = [];
        colorizeIcons = false;
        size = 1.25;
      };
      network = {
        wifiEnabled = true;
      };
      notifications = {
        doNotDisturb = false;
        monitors = [];
        location = "top_right";
        overlayLayer = true;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
      };
      osd = {
        enabled = true;
        location = "top_right";
        monitors = [];
        autoHideMs = 2000;
        overlayLayer = true;
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 60;
        visualizerType = "linear";
        mprisBlacklist = [];
        preferredPlayer = "";
      };
      ui = {
        fontDefault = "JetBrains Nerd Font";
        fontFixed = "JetBrains Mono Nerd Font";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelsOverlayLayer = true;
      };
      brightness = {
        brightnessStep = 5;
      };
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Noctalia (default)";
        darkMode = true;
        matugenSchemeType = "scheme-fruit-salad";
        generateTemplatesForPredefined = true;
      };
      templates = {
        gtk = false;
        qt = false;
        kcolorscheme = false;
        kitty = false;
        ghostty = false;
        foot = false;
        fuzzel = false;
        discord = false;
        discord_vesktop = false;
        discord_webcord = false;
        discord_armcord = false;
        discord_equibop = false;
        discord_lightcord = false;
        discord_dorion = false;
        pywalfox = false;
        enableUserTemplates = false;
      };
      nightLight = {
        enabled = true;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "08:00";
        manualSunset = "19:00";
      };

      colors = {
        # you must set ALL of these
        mError = "#dddddd";
        mOnError = "#111111";
        mOnPrimary = "#111111";
        mOnSecondary = "#111111";
        mOnSurface = "#828282";
        mOnSurfaceVariant = "#5d5d5d";
        mOnTertiary = "#111111";
        mOutline = "#3c3c3c";
        mPrimary = "#aaaaaa";
        mSecondary = "#a7a7a7";
        mShadow = "#000000";
        mSurface = "#111111";
        mSurfaceVariant = "#191919";
        mTertiary = "#cccccc";
      };

      # Audio and brightness settings
      audio = {
        volumeIncrement = 5;
        brightnessIncrement = 5;
      };

      # Notification settings
      notifications = {
        lowUrgency = {
          location = "top-right";
          timeout = 5000;
        };
        normalUrgency = {
          location = "top-right";
          timeout = 10000;
        };
        criticalUrgency = {
          location = "top-right";
          timeout = 0; # No timeout for critical
        };
      };
    };
  };
}
