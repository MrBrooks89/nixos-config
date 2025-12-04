{config, ...}: {
  programs.sherlock = {
    enable = true;
    # config.toml
    settings = {
      debug = {
        try_suppress_warnings = true;
      };
      default_apps = {
        teams = "teams-for-linux --enable-features=UseOzonePlatform --ozone-platform=wayland";
        terminal = "kitty";
      };
      units = {
        lengths = "feet";
        weights = "lb";
        volumes = "gal";
        temperatures = "F";
        currency = "usd";
      };
      appearance = {
        width = "900";
        height = "593";
        opacity = "0.9";
      };
    };
    # sherlock_alias.json
    aliases = {
      vesktop = {name = "Discord";};
    };
    # sherlockignore
    ignore = ''
      Avahi*
    '';
    # fallback.json
    launchers = [
      {
        name = "App Launcher";
        alias = "app";
        type = "app_launcher";
        args = {};
        priority = 1;
        home = "Home";
      }
      {
        name = "Weather";
        type = "weather";
        args = {
          location = "longview";
          update_interval = 60;
        };
        priority = 1;
        home = "OnlyHome";
        async = true;
        shortcut = false;
        spawn_focus = false;
      }
      {
        name = "Calculator";
        type = "calculation";
        args = {
          capabilities = [
            "calc.math"
            "calc.units"
          ];
        };
        priority = 1;
      }
      {
        name = "Power Management";
        alias = "pm";
        type = "command";
        args = {
          commands = {
            "Shutdown" = {
              icon = "system-shutdown";
              icon_class = "reactive";
              exec = "poweroff";
              search_string = "shutdown";
              tag_start = "{keyword}";
              tag_end = "{keyword}";
            };
            "Sleep" = {
              icon = "system-suspend";
              icon_class = "reactive";
              exec = "suspend";
              search_string = "sleep";
              tag_start = "{keyword}";
              tag_end = "{keyword}";
            };
            "Lock" = {
              icon = "system-lock-screen";
              icon_class = "reactive";
              exec = "hyprlock";
              search_string = "lock screen";
              tag_start = "{keyword}";
              tag_end = "{keyword}";
            };
            "Reboot" = {
              icon = "system-reboot";
              icon_class = "reactive";
              exec = "reboot";
              search_string = "reboot";
              tag_start = "{keyword}";
              tag_end = "{keyword}";
            };
          };
        };
        priority = 5;
        home = "Home";
      }
      {
        name = "Web Search";
        display_name = "DuckDuckGo";
        tag_start = "{keyword}";
        tag_end = "{keyword}";
        alias = "ddg";
        type = "web_launcher";
        args = {
          search_engine = "duckduckgo";
          icon = "duckduckgo";
        };
        priority = 100;
      }
    ];
  };
}
