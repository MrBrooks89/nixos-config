{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
      ./vm.nix
    ];
# Bootloader. Test 2
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; 


# Enable Docker
  virtualisation.docker.enable = true;

# Enable Niri
	programs.niri = {
		enable = true;
	};

services.displayManager.gdm = {
        enable = true;
        wayland = true;
};

# # Enable SDDM Display Manager
#   services.displayManager.sddm = {
#     enable = true;
#     wayland.enable = true;
#   };

# services.desktopManager.gnome.enable = true; # Enable GNOME

# # Enable hyprland
#   programs.hyprland = {
#     enable = true;
#     xwayland.enable = true;
#   };

# Enable Neovim
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  # };
  #
# Enable nix-ld-rs to run non-nix executables | Needed for Neovim Plugins
programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
# Fixes Electron/Wayland apps
environment.sessionVariables.NIXOS_OZONE_WL = "1";  

# Required to be able to use zsh as default shell
programs.zsh.enable = true;

# Enable networking
networking.networkmanager.enable = true;
boot.kernelParams = [ "nohibernate" ];

# Enable BBR congestion control
boot.kernelModules = [ "tcp_bbr" "iptable_nat" "iptables" ]; # Enables BBR
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
hardware.xpadneo.enable = true; # Enable the xpadneo driver for Xbox BT Controller

boot = {
  extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
  extraModprobeConfig = ''
    options bluetooth disable_ertm=Y
    '';
};

# Enable the X11 windowing system.
# services.xserver = {
#         enable = true; # Required for GDM
# };
#
#
# Enable CUPS to print documents.
services.printing = {
  enable = true;
  drivers = with pkgs; [ cnijfilter2 ];
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
    deviceUri = "http://192.168.5.114:631/";
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
      extraGroups = [ "networkmanager" "wheel" "audio" "sharedgroup" "docker" ];
    };
  };
};


# Allow unfree packages
nixpkgs.config.allowUnfree = true;

# Packages needed for initial config
environment.systemPackages = with pkgs; [
  git
  kitty
  lact
  home-manager
  gnome-tweaks
  gnome-extension-manager
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

# Enable gamemode
programs.gamemode.enable = true;

# Disable IPv6
networking.enableIPv6 = false;



# It‘s perfectly fine and recommended to leave  this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "24.05"; # Did you read the comment?

}
