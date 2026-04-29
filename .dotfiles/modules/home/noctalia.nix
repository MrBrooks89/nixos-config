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
  home.packages = [inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default];

  # Enable and configure Noctalia Shell
  programs.noctalia-shell = {
    enable = true;
    settings = {
      # Bar configuration
      bar = {
        barType = "simple";
        position = "top";
        density = "default";
        showOutline = true;
        showCapsule = true;
        capsuleOpacity = 1;
        capsuleColorKey = "none";
        widgetSpacing = 6;
        widgetPadding = 2;
        fontScale = 1;
        enableExclusionZoneInset = true;
        useSeparateOpacity = true;
        backgroundOpacity = 0;
        hideOnOverview = false;
        outerCorners = true;
        displayMode = "always_visible";
        widgets = {
          left = [
            {id = "SystemMonitor";}
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
            {id = "screen-recorder";}
            {id = "Volume";}
            {id = "Network";}
            {id = "Clock";}
            {id = "ControlCenter";}
          ];
        };
      };

      # General settings
      general = {
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
        overviewEnabled = false;
        directory = "/home/mrbrooks/Pictures/Wallpapers";
        enableMultiMonitorDirectories = false;
        showHiddenFiles = false;
        viewMode = "single";
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        useSolidColor = false;
        automationEnabled = true;
        randomIntervalSec = 300;
        transitionDuration = 1500;
        wallpaperChangeMode = "random";
        transitionEdgeSmoothness = 0.05;
        transitionType = [
          "fade"
          "disc"
          "stripes"
          "wipe"
          "pixelate"
          "honeycomb"
        ];
        skipStartupTransition = false;
        panelPosition = "follow_bar";
        overviewBlur = 0.4;
        overviewTint = 0.6;
        useWallhaven = false;
        sortOrder = "name";
        favorites = [];
      };

      appLauncher = {
        enableClipboardHistory = false;
        position = "center";
        backgroundOpacity = 1;
        pinnedApps = [];
        widgetOutlines = true;
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
      };

      controlCenter = {
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {id = "WiFi";}
            {id = "Bluetooth";}
            {id = "ScreenRecorder";}
            {id = "WallpaperSelector";}
          ];
          right = [
            {id = "Notifications";}
            {id = "PowerProfile";}
            {id = "KeepAwake";}
            {id = "NightLight";}
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

      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        swapWarningThreshold = 80;
        swapCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        diskAvailWarningThreshold = 20;
        diskAvailCriticalThreshold = 10;
        batteryWarningThreshold = 20;
        batteryCriticalThreshold = 5;
        enableDgpuMonitoring = false;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };

      dock = {
        displayMode = "auto_hide";
        enabled = false;
        backgroundOpacity = 0;
        floatingRatio = 0;
        onlySameOutput = false;
        monitors = ["HDMI-A-1"];
        pinnedApps = [];
        colorizeIcons = false;
        size = 1.25;
        dockType = "attached";
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
        lowUrgencyDuration = 5;
        normalUrgencyDuration = 10;
        criticalUrgencyDuration = 0;
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
        volumeIncrement = 5;
        brightnessIncrement = 5;
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
        predefinedScheme = "Dracula";
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
    };

    colors = {
      mError = "#ff5555";
      mOnError = "#000000";
      mOnPrimary = "#000000";
      mOnSecondary = "#f8f8f2";
      mOnSurface = "#f8f8f2";
      mOnSurfaceVariant = "#bd93f9";
      mOnTertiary = "#000000";
      mOutline = "#bd93f9";
      mPrimary = "#bd93f9";
      mSecondary = "#6272a4";
      mShadow = "#000000";
      mSurface = "#000000";
      mSurfaceVariant = "#111111";
      mTertiary = "#ff79c6";
    };

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Offical Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
