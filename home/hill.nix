{ config, pkgs, lib, ... }:

let 
  waybar-style = {
    margin = {
      left = "8px";
      right = "8px";
      top = "4px";
      bottom = "4px";
    };
    padding = {
      left = "16px";
      right = "16px";
    };
    border-radius = "10px";
    transition = "none";
    color = "#ffffff";
    background = "#383c4a";
  };
  waybar-module-default = with waybar-style; ''
    margin-right: ${margin.right};
    padding-left: ${padding.left};
    padding-right: ${padding.right};
    border-radius: ${border-radius};
    transition: ${transition};
    color: ${color};
    background: ${background};
  '';

in {
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
  #TODO: switch to alacritty
  programs.kitty = {
    enable = true;
    theme = "One Dark";
    font.size = 11;
    font.name = "Julia Mono";
    extraConfig = "background_opacity 0.95";
  };
  programs.tmux = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ll = "ls -l";
      flakeed = "hx ~/.dotfiles/flake.nix"; # Update system config Flake
      nixed = "hx ~/.dotfiles/system/configuration.nix"; # edit system config
      homeed = "hx ~/.dotfiles/users/hill/home.nix"; # edit this file
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
        "autojump"
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
  programs.nnn = {
    enable = true;
    # package = pkgs.nnn.override ({ withNerdIcons = true; });
    bookmarks = {
      d = "~/Developer";
      D = "~/Downloads";
    };
  };
  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
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
        outer = 1;
        smartBorders = "on";
        smartGaps = true;
      };
      startup = [
        { command = "waybar"; }
        { command = "sworkstyle";}
      ];
      # assigns = {
      #   "2" = [{ app_id = "firefox"; }];
      #   "3" = [{ app_id = "telegram-desktop"; }];
      # };
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
      # DPI settings four each output device:
      output.eDP-1.scale = "1.2";
      output.HDMI-A-1.scale = "1.1";
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
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "cpu"
          "memory"
          "temperature"
          "bluetooth"
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
        "bluetooth" = {
        	# controller = "controller1"; # specify the alias of the controller if there are more than 1 on the system
        	format = " {status}";
        	format-disabled = ""; # an empty format will hide the module
        	format-connected = " {num_connections} connected";
        	tooltip-format = "{controller_alias}\t{controller_address}";
        	tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        	tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
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
    # Style adapted from Igaboury's config
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: Julia Mono;
          min-height: 20px;
      }

      window#waybar {
          background: transparent;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces {
          margin-left: ${waybar-style.margin.left};
          margin-right: ${waybar-style.margin.right};
          border-radius: ${waybar-style.border-radius};
          transition: ${waybar-style.transition};
          background: ${waybar-style.background};
      }

      #workspaces button {
          transition: none;
          color: #7c818c;
          background: transparent;
          padding: 5px;
          font-size: 18px;
      }

      #workspaces button.persistent {
          color: #7c818c;
          font-size: 12px;
      }
      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          transition: none;
          box-shadow: inherit;
          text-shadow: inherit;
          border-radius: inherit;
          color: #383c4a;
          background: #7c818c;
      }
      #workspaces button.focused {
          color: white;
      }
      #mode {${waybar-module-default}}
      #clock {${waybar-module-default}}
      #pulseaudio {${waybar-module-default}}
      #pulseaudio.muted {
          background-color: #90b1b1;
          color: #2a5c45;
      }
      #cpu {${waybar-module-default}}
      #memory {${waybar-module-default}}
      #network {${waybar-module-default}}
      #bluetooth {${waybar-module-default}}
      #temperature {${waybar-module-default}}
      #temperature.critical {
          background-color: #eb4d4b;
      }
      #backlight {${waybar-module-default}}
      #battery {${waybar-module-default}}
      #battery.charging {
          color: #ffffff;
          background-color: #26A65B;
      }
      #battery.warning:not(.charging) {
          background-color: #ffbe61;
          color: black;
      }
      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
      }
      #tray {${waybar-module-default}}
      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }
    '';
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
