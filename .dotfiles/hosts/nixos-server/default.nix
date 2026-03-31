{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/gaming.nix
    ../../modules/desktop.nix
    ../../modules/dev.nix
    ../../modules/printer.nix
    ../../modules/network.nix
    ../../modules/system.nix
  ];

  # Enable Custom Modules
  myModules.gaming.enable = false;
  myModules.desktop.enable = false;
  myModules.dev.enable = true;
  myModules.printer.enable = false;
  myModules.network.enable = true;
  myModules.system.enable = true;
  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos-server"; # Define your hostname.

  # Required to be able to use zsh as default shell
  programs.zsh.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Cron Jobs
  services.cron = {
    enable = true;
    systemCronJobs = [
      # Runs at 2am every Friday as mrbrooks
      "0 2 * * 5 mrbrooks bash /home/mrbrooks/backup_to_nas.sh"
      "0 5 * * 5 mrbrooks docker restart qbittorrent"
    ];
  };

  #Cloudflared Tunnels
  services.cloudflared = {
    enable = true;
    tunnels = {
      "HomeLab" = {
        ingress = {
          "glance.mrbrooks.tech" = {
            service = "http://192.168.6.30:8084";
          };
          "nextcloud.mrbrooks.tech" = {
            service = "https://192.168.6.30:8043";
            originRequest = {noTLSVerify = true;};
          };
          "jellyfin.mrbrooks.tech" = {
            service = "http://192.168.6.30:8096";
          };
          "ssh.mrbrooks.tech" = {
            service = "ssh://localhost:22";
            originRequest = {proxyType = "";};
          };
          "portainer.mrbrooks.tech" = {
            service = "https://192.168.6.30:9443";
            originRequest = {noTLSVerify = true;};
          };
          "opnsense.mrbrooks.tech" = {
            service = "https://192.168.4.1";
            originRequest = {noTLSVerify = true;};
          };
          "proxmox.mrbrooks.tech" = {
            service = "https://192.168.4.25:8006";
            originRequest = {noTLSVerify = true;};
          };
          "adguard.mrbrooks.tech" = {
            service = "http://192.168.4.1:8080";
          };
        };
        credentialsFile = "/home/mrbrooks/.cloudflared/0bcf4c56-d7de-4308-a62d-21cd005c1ab5.json";
        default = "http_status:404";
      };
    };
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user accounts
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      mrbrooks = {
        isNormalUser = true;
        description = "MrBrooks";
        extraGroups = ["networkmanager" "wheel" "audio" "sharedgroup" "docker"];
      };
    };
  };

  # Packages needed for initial config
  environment.systemPackages = with pkgs; [
    git
    kitty
    home-manager
    wget
    cifs-utils
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # It‘s perfectly fine and recommended to leave  this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
