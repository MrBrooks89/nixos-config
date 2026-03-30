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
    ./modules/gaming.nix
    ./modules/desktop.nix
    ./modules/dev.nix
  ];

  # Enable Custom Modules
  myModules.gaming.enable = true;
  myModules.desktop.enable = true;
  myModules.dev.enable = true;
  # Bootloader. Test 2
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  networking.hostName = "nixos";

  # Manually Set NTP Server
  services.timesyncd = {
    enable = true;
    servers = ["192.168.4.1"];
  };

  # Required to be able to use zsh as default shell
  programs.zsh.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  boot.kernelParams = ["nohibernate" "amdgpu.ppfeaturemask=0xffffffff"];

  # Enable BBR congestion control
  boot.kernelModules = ["tcp_bbr" "iptable_nat" "iptables"]; # Enables BBR
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr"; # Enables  BBR
  boot.kernel.sysctl."net.core.default_qdisc" = "fq"; # Sets QOS to fair queueing for outbound traffic
  boot.kernel.sysctl."net.core.wmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.core.rmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.ipv4.tcp_rmem" = "4096 87380 1073741824"; # 1 GiB max
  boot.kernel.sysctl."net.ipv4.tcp_wmem" = "4096 87380 1073741824"; # 1 GiB max

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "Mon 15:00";
    options = "--delete-older-than 20d";
  };

  # Enable automatic storage optimization
  nix.optimise = {
    automatic = true;
    dates = "Mon 15:15";
  };

  # Nix Settings
  nix.settings = {
    substituters = ["https://attic.xuyh0120.win/lantian"];
    trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
    auto-optimise-store = true; # automatic deduplication of the nix store
    download-buffer-size = 33554432; # increase buffer size 32MiB for 1Gb internet
  };

  # Enable automatic loading of AMD CPU microcode updates
  hardware.cpu.amd.updateMicrocode = true;
  # Enable firmware upgrades
  services.fwupd.enable = true;

  # Enable trim fro SSDs
  services.fstrim = {
    enable = true;
    interval = "Mon 15:30";
  };

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  #Enable Bluetooth
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

  # Enable the X11 windowing system.
  # services.xserver = {
  #         enable = true; # Required for GDM
  # };
  #
  #
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [cnijfilter2];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
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

  # Disable sound with pulseaudio
  services.pulseaudio.enable = false;
  # Enable Sound with pipwire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #   services.pipewire.extraConfig.pipewire."92-low-latency" = {
  #     "context.properties" = {
  #       "default.clock.rate" = 48000;
  #       "default.clock.quantum" = 32;
  #       "default.clock.min-quantum" = 32;
  #       "default.clock.max-quantum" = 32;
  #     };
  #   };

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];

  # Packages needed for initial config
  environment.systemPackages = with pkgs; [
    git
    kitty
    lact
    home-manager
    inputs.yt-x.packages.${stdenv.hostPlatform.system}.default
    # gnome-tweaks
    # gnome-extension-manager
    # inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
  ];

  # Enable LACTD Service For GPU Management with LACT
  systemd.services.lact = {
    description = "AMDGPU Control Daemon";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
    };
    enable = true;
  };

  # Disable IPv6
  networking.enableIPv6 = false;

  # It‘s perfectly fine and recommended to leave  this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
