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
    ./vscode
    ./cli
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.username = "hill";
  home.homeDirectory = "/home/hill";

  colorscheme = colorSchemes.decaf;

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

    #===== TUI & CLI utils =====#
    # Several CLI modules are defined in ./modules/cli 
    # Replacement for ls and tree
    exa
    # Terminal multiplexer
    tmux
    # File manager
    ranger
    # Fast find alternative
    fd
    # Fuzzy finder
    fzf
    # Fast grep alternative
    ripgrep
    # Process viewer, replaces htop
    bottom
    nvtop # GPU monitoring
    # PCI utilities, e.g. lspci
    pciutils
    # Print system information
    neofetch
    # du alternative
    du-dust
    # Git Terminal UI
    gitui
    # Messaging clients
    weechat
    # CLI helper
    tealdeer
    # Habit tracker
    dijo

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
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    linuxPackages.nvidia_x11
    # Julia
    julia-bin
    # Python
    poetry
    python310
    python310Packages.ipython
    python310Packages.jupyter
    python310Packages.jupyterlab
    # GCC
    gcc
    # Rust
    rustup
    rust-analyzer
    # Nix LSP
    rnix-lsp
    # Markdown LSP
    marksman

    #===== Other =====#
    # Make GNOME icon themes available
    gnome.adwaita-icon-theme
  ];

  home.sessionVariables = {
    CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
    CUDNN_PATH = "${pkgs.cudaPackages.cudnn}";
    LD_LIBRARY_PATH = "${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.cudaPackages.cudatoolkit}/lib:${pkgs.cudaPackages.cudnn}/lib";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };

  gtk.iconTheme = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
  };

  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
