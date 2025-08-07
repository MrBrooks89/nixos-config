{ config, pkgs, lib, ... }:

{
  programs.sherlock = {
    enable = true;

    settings = {
      aliases = {
        vesktop = {
          name = "Discord";
        };
      };

      config = {
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
      };

      ignore = ''
        Avahi*
      '';

      launchers = [
        {
          name = "Weather";
          type = "Weather";
          args = {
            location = "longview";
            update_interval = 60;
          };
          actions = [
            {
              name = "Show in Web";
              exec = "https://www.wttr.in/longview";
              icon = "sherlock-link";
              method = "web_launcher";
            }
          ];
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
            on_return = "copy";            
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
          }
      ];

      style = null; 
    };
  };
}