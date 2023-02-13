{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Automatically update packages
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 3; # wait time until boot
    };
  };

  # Enable NVIDIA GPU with Optimus
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:2:0:0"; # shown using lspci
    intelBusId = "PCI:0:2:0";
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # Systen-wide priviledges for Sway
  security.polkit.enable = true;

  # XDG Integration for Wayland & Sway
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
  # Start sway automatically
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  # Enable networking
  networking.hostName = "nixos"; # hostname.
  networking.networkmanager.enable = true;
  # Use wpa_supplicant directly:
  #networking.wireless.userControlled.enable = true;

  # Select internationalisation properties.
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Backlight
  programs.light.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true; # GUI

  # Add keychain
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    vim
    helix
    kitty
    firefox
  ];

  fonts.fonts = with pkgs; [
    julia-mono
    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    material-design-icons
    material-icons
  ];

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  environment.variables = {
    EDITOR = "hx"; # Helix
    BROWSER = "firefox";
    TERMINAL = "kitty";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  users.users.hill = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "optical"
      "storage"
    ];
  };

  system.stateVersion = "22.11";
}
