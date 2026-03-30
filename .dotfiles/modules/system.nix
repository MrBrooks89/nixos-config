{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myModules.system;
in {
  options.myModules.system = {
    enable = mkEnableOption "Enable System Maintenance & Nix Optimization";
  };

  config = mkIf cfg.enable {
    # Nix Settings & Optimization
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://attic.xuyh0120.win/lantian"];
      trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
      auto-optimise-store = true; # automatic deduplication
      download-buffer-size = 33554432; # 32MiB
    };

    # Automatic Garbage Collection
    nix.gc = {
      automatic = true;
      dates = "Mon 15:00";
      options = "--delete-older-than 20d";
    };

    # Automatic Storage Optimization
    nix.optimise = {
      automatic = true;
      dates = "Mon 15:15";
    };

    # Hardware Maintenance
    services.fstrim = {
      enable = true;
      interval = "Mon 15:30";
    };
    services.fwupd.enable = true;
    hardware.cpu.amd.updateMicrocode = true;

    # Allow unfree packages system-wide
    nixpkgs.config.allowUnfree = true;
  };
}
