{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myModules.printer;
in {
  options.myModules.printer = {
    enable = mkEnableOption "Enable printer support";
  };

  config = mkIf cfg.enable {
    # Enable CUPS to print documents.
    services.printing = {
      enable = true;
      drivers = with pkgs; [cnijfilter2];
    };

    # Manully Set Canon Printer
    hardware.printers = {
      ensurePrinters = [
        {
          name = "Canon_MB2720";
          location = "Home";
          deviceUri = "http://192.168.5.105:631/";
          model = "canonmb2700.ppd";
          ppdOptions = {
            PageSize = "Letter Small";
          };
        }
      ];
      ensureDefaultPrinter = "Canon_MB2720";
    };

    # Avahi for network printer discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
