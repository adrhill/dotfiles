{ config, pkgs, lib, ... }:

{
  home.username = "hill";
  home.homeDirectory = "/home/hill";

  nixpkgs.config.allowUnfree = true;    
  home.packages = with pkgs; [
    # Packages for Sway
    # swaylock # TODO: configure before using
    waybar      
    swayest-workstyle # workspace names to window icons # TODO: fix icons
    swayidle
    swaybg # wallpaper
    wl-clipboard # copy to clipboard
    grim # screenshots:w
    mako
    wofi
    # CLI utils
    tmux
    nnn
    bat
    fd
    fzf
    ripgrep
    tree
    htop
    pciutils # lspci & Co.
    comma
    neofetch
    gitui
    tldr
    # GUI
    firefox
    tdesktop # Telegram
    networkmanagerapplet
    imv # image viewer
    spotify-player
    # Programming
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
