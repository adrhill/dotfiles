{ inputs, lib, pkgs, config, outputs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) nixWallpaperFromScheme;

in
{
  imports = [
    inputs.nix-colors.homeManagerModule
    ./wm
    ./term
    ./shell
    ./helix
    ./cli
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = "hill";
  home.homeDirectory = "/home/hill";

  # Use existing colorscheme:
  # colorscheme = colorSchemes.oceanicnext;

  # Define own colorscheme:
  colorscheme = {
    slug = "ghdd"; # modification of GitHub's Dark-dimmed
    name = "GitHub Dark-dimmed";
    author = "Adrian Hill";
    colors = {
      # Grays
      base00 = "#22272E"; # Default Background
      base01 = "#373E47"; # Lighter Background (Used for status bars, line number and folding marks)
      base02 = "#444C56"; # Selection Background
      base03 = "#545D68"; # Comments, Invisibles, Line Highlighting
      base04 = "#768390"; # Dark Foreground (Used for status bars)
      base05 = "#909DAB"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "#ADBAC7"; # Light Foreground (Not often used)
      base07 = "#CDD9E5"; # Light Background (Not often used)
      # Colors
      base08 = "#F47067"; # RED       - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "#E0823D"; # ORANGE    - Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "#DAAA3F"; # YELLOW    - Classes, Markup Bold, Search Text Background
      base0B = "#57AB5A"; # GREEN     - Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "#96D0FF"; # LIGHTBLUE - Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "#6CB6FF"; # BLUE      - Functions, Methods, Attribute IDs, Headings
      base0E = "#DCBDFB"; # PINK      - Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "#AE5622"; # PURPLE    - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };
  };

  wallpaper = nixWallpaperFromScheme {
    scheme = config.colorScheme;
    width = 3840;
    height = 2160;
    logoScale = 10.0;
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    #===== Packages for Sway =====#
    # swaylock # TODO: configure before using
    # Launcher
    wofi
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
    # Fast find alternative
    fd
    # Fuzzy finder
    fzf
    # Fast grep alternative
    ripgrep
    # Process viewer, replaces htop
    bottom
    # PCI utilities, e.g. lspci
    pciutils
    # Print system information
    neofetch
    # Git Terminal UI
    gitui
    # Messaging clients
    weechat
    # CLI helper
    tldr

    #===== GUI =====#
    firefox
    # Image viewer
    imv
    # Note taking
    obsidian
    # Network manager GUI
    networkmanagerapplet
    # Telegr
    tdesktop
    # Spotify
    spotify-player

    #===== Programming =====#
    # GPU support
    cudatoolkit
    # Julia
    julia-bin
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
