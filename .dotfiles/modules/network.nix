{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.myModules.network;
in {
  options.myModules.network = {
    enable = mkEnableOption "Enable Advanced Networking & Connectivity (BBR, NM, Bluetooth)";
  };

  config = mkIf cfg.enable {
    # Core Networking
    networking.networkmanager.enable = true;
    networking.enableIPv6 = false;

    # Manually Set NTP Server
    services.timesyncd = {
      enable = true;
      servers = ["192.168.4.1"];
    };

    # Bluetooth Support
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        experimental = true; # show battery
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = true;
      };
    };
    services.blueman.enable = true;

    # TCP BBR Congestion Control & Performance Tweaks
    boot.kernelModules = ["tcp_bbr"];
    boot.kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.core.wmem_max" = 1073741824; # 1 GiB
      "net.core.rmem_max" = 1073741824; # 1 GiB
      "net.ipv4.tcp_rmem" = "4096 87380 1073741824"; # 1 GiB max
      "net.ipv4.tcp_wmem" = "4096 87380 1073741824"; # 1 GiB max
    };
  };
}
