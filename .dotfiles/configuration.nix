{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vm.nix
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
 
  networking.hostName = "nixos"; 

  
  # Enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  

  # Required to be able to use zsh as default shell
  programs.zsh.enable = true;


  # Enable networking
  networking.networkmanager.enable = true;
  boot.kernelParams = [ "nohibernate" ];

  # Enable BBR congestion control
  boot.kernelModules = [ "tcp_bbr" ]; # Enables BBR
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr"; # Enables  BBR
  boot.kernel.sysctl."net.core.default_qdisc" = "fq"; # Sets QOS to fair queueing for outbound traffic
  boot.kernel.sysctl."net.core.wmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.core.rmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.ipv4.tcp_rmem" = "4096 87380 1073741824"; # 1 GiB max
  boot.kernel.sysctl."net.ipv4.tcp_wmem" = "4096 87380 1073741824"; # 1 GiB max

  
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;
   
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio = true;
  services.pipewire.enable = false;
  security.rtkit.enable = true;
 # services.pipewire = {
 #   enable = true;
 #   alsa.enable = true;
 #   alsa.support32Bit = true;
 #   pulse.enable = true;
 # };

#   services.pipewire.extraConfig.pipewire."92-low-latency" = {
#     "context.properties" = {
#       "default.clock.rate" = 48000;
#       "default.clock.quantum" = 32;
#       "default.clock.min-quantum" = 32;
#       "default.clock.max-quantum" = 32;
#     };
#   };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.mrbrooks = {
    isNormalUser = true;
    description = "mrbrooks";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };
    users.mrsbrooks = {
    isNormalUser = true;
    description = "mrsbrooks";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };
};
  

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    git
    kitty
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default


];


  # Enables fonts
  fonts.packages = with pkgs; [
  font-awesome
  powerline-fonts
  powerline-symbols
  nerd-fonts.jetbrains-mono
  ];

  # Enables and installs steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Sets steam location for Proton GE
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };
  
  # Enable gamemode use gamemode %command in steam options
  programs.gamemode.enable = true;
  
  # Disable IPv6
  networking.enableIPv6 = false;


#   # Set Unsecure Algorithms for 2960x SSH connection
#   programs.ssh.extraConfig = ''
#     Host 192.168.4.25
#         KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
#         Ciphers +aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc
#         HostKeyAlgorithms +ssh-rsa
#         PubkeyAcceptedAlgorithms +ssh-rsa
#   '';




  # It‘s perfectly fine and recommended to leave  this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
