{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules
    ../themes
  ];

  home.username = "hill";
  home.homeDirectory = "/home/hill";

  nixpkgs.config.allowUnfree = true;    
  home.packages = with pkgs; [
    #===== Packages for Sway =====#
    # swaylock # TODO: configure before using
    # Launcher
    wofi
    # Use window icons as workspace names
    swayest-workstyle # TODO: fix icons
    # Notifications
    mako
    # Idle management
    swayidle
    # Set wallpaper
    swaybg
    # Copy to clipboard
    wl-clipboard
    # Take screenshots
    grim
    #===== CLI utils =====#
    # Terminal multiplexer
    tmux
    # File manager
    nnn
    # Pretty 'cat'
    bat
    # Fast 'find'
    fd
    # Fuzzy finder
    fzf
    ripgrep
    # Process viewer
    htop
    # PCI utilities, e.g. lspci
    pciutils
    # Print system information
    neofetch
    # Git Terminal UI
    gitui
    # CLI helper
    tldr
    #===== GUI =====#
    firefox
    # Image viewer
    imv
    # Network manager GUI
    networkmanagerapplet
    # Telegram
    tdesktop
    # Spotify
    spotify-player
    #===== Programming =====#
    cudatoolkit
    julia
    python310
    poetry
    # Make GNOME icon themes available
    gnome.adwaita-icon-theme
  ];

  gtk.iconTheme = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
  };
  
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
