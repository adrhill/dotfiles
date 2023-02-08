{ config, pkgs, lib, ... }:

{
  home.username = "hill";
  home.homeDirectory = "/home/hill";

  nixpkgs.config.allowUnfree = true;    
  home.packages = with pkgs; [
    # Packages for Sway
    # swaylock # TODO: configure before using
    swayidle
    swaybg # wallpaper
    wl-clipboard # copy to clipboard
    mako
    wofi
    waybar      
    # CLI utils
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
    networkmanagerapplet
    imv # image viewer
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
  #TODO: switch to alacritty
  programs.kitty = {
    enable = true;
    theme = "One Dark";
    font.size = 11;
    font.name = "Julia Mono";
    # extraConfig = "background_opacity 0.9";
  };
  programs.tmux = {
    enable = true;
  };
  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true; 
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi --show run";
      bars = [];
      gaps = {
        inner = 8;
        outer = 0;
        smartBorders = "on";
        smartGaps = true;
      };
      startup = [
        { command = "waybar"; }
        # { command = "firefox"; }
      ];
      # assigns = {
      #   "1" = [{ app_id = "kitty"; }];
      # }
      input = {
        "type:keyboard" = {
          xkb_options = "caps:escape,ctrl:swap_lalt_lctl";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.5";
        };
      };
      output = {
        "*" = {
          "bg" = "/home/hill/.background-image fill";
        };
      };
      keybindings = lib.mkOptionDefault{
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 -5%";
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 toggle";
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";
        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";
      };
      output.eDP-1.scale = "1.2"; # DPI
    };
    extraOptions = [
      "--unsupported-gpu" # NVIDIA drivers
    ];
  };
  programs.waybar = {
    enable = true;
    systemd.target = "sway-session.target";
    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "cpu"
          "memory"
          "temperature"
          "network"
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
        "cpu" = {
          format = "{usage}% ";
          tooltip = true;
        };
        "memory" = { format = "{}% "; };
        "temperature" = {
          critical-threshold = 80;
          format =  "{temperatureC}°C {icon}";
          format-icons = [" " "" ""];
        };
        "network" = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = " 0%";
          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
        };
        "battery" = {
          bat = "BAT0";
          states = {
            "warning" = 30;
            "critical" = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };
        "clock" = {
          tooltip-format =  "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      }
    ];
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ll = "ls -l";
      flakeed = "hx .dotfiles/flake.nix"; # Update system config Flake
      nixed = "hx .dotfiles/system/configuration.nix"; # edit system config
      homeed = "hx .dotfiles/users/hill/home.nix"; # edit this file
      nixgc = "nix-collect-garbage -d"; # Run GC
      copycb = "xclip -selection clipboard";
      code = "codium";
      gitgraph = "git log --oneline --decorate --graph";
    };
    history.size = 20000;
    #autosuggestions.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "history"
        "copyfile"
        "copypath"
        "sudo"
        "web-search"
        "poetry"
      ];
    };
  };
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      editor.rulers = [88 120];
    };
  };    
  programs.git = {
    enable = true;
    userName = "adrhill";
    userEmail = "adrian.hill@mailbox.org";
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      usernamehw.errorlens
      gruntfuggly.todo-tree
      github.github-vscode-theme
      bungcip.better-toml
      james-yu.latex-workshop
    ];
  };

  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
