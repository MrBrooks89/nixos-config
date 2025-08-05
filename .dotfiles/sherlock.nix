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
          teams = "teams-for-linux --enable-features=UseOzonePlatform --ozone-platform=wayland --url {meeting_url}";
          terminal = "kitty";
        };
        units = {
            lenghts = "feet";
            weights = "lb";
            volumens = "gal";
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
            location = "Longview, TX";
            update_interval = 60;
          };
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
