{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ../hardware-configuration.nix
    ../modules/gaming.nix
    ../modules/desktop.nix
    ../modules/dev.nix
    ../modules/printer.nix
    ../modules/network.nix
    ../modules/system.nix
  ];

  # Enable Custom Modules
  myModules.gaming.enable = true;
  myModules.desktop.enable = true;
  myModules.dev.enable = true;
  myModules.printer.enable = true;
  myModules.network.enable = true;
  myModules.system.enable = true;
  # Bootloader. Test 2
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  networking.hostName = "gamingdesktop";

  # Required to be able to use zsh as default shell
  programs.zsh.enable = true;

  # Enable networking
  boot.kernelParams = ["nohibernate" "amdgpu.ppfeaturemask=0xffffffff"];

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

  services.blueman.enable = true;

  # Disable sound with pulseaudio
  services.pulseaudio.enable = false;
  # Enable Sound with pipwire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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

  nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];

  # Packages needed for initial config
  environment.systemPackages = with pkgs; [
    git
    kitty
    lact
    home-manager
    inputs.yt-x.packages.${stdenv.hostPlatform.system}.default
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

  # It‘s perfectly fine and recommended to leave  this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
