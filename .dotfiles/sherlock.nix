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
            priority = 1;
            on_return = "copy";
            };
            
        }
      ];

      style = null; 
    };
  };
}