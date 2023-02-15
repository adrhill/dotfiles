{ pkgs, config, nix-colors, lib, ... }:

# let
#   nix-colors-lib-contrib = nix-colors.lib-contrib { inherit pkgs; };

# in
{
  imports = [
    ./modules
    nix-colors.homeManagerModule
  ];

  home.username = "hill";
  home.homeDirectory = "/home/hill";

  colorscheme = nix-colors.colorSchemes.oceanicnext;
  # wallpaper = nix-colors-lib-contrib.nixWallpaperFromScheme {
  #   scheme = config.colorScheme;
  #   width = 3840;
  #   height = 2160;
  #   logoScale = 5.0;
  # };

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
    # Several CLI modules are defined in ./modules/cli 
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
    bottom
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
    # GPU support
    cudatoolkit
    # Julia
    julia
    # Python
    python310
    poetry
    # Nix LSP
    rnix-lsp
    #===== Other =====#
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
