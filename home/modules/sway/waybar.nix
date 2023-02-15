{ pkgs, config, ... }:

let
  inherit (config.colorscheme) colors;

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
    colorscheme = {
      # https://github.com/tinted-theming/home/blob/main/styling.md
      background = "#${colors.base00}"; # default background
      foreground = "#${colors.base05}"; # default foreground
      red = "#${colors.base08}"; # usually red
      green = "#${colors.base0B}"; # usually green
    };
  };

  waybar-module-default = with waybar-style; ''
    margin-right: ${margin.right};
    padding-left: ${padding.left};
    padding-right: ${padding.right};
    border-radius: ${border-radius};
    transition: ${transition};
    color: ${colorscheme.foreground};
    background: ${colorscheme.background};
  '';

in
{
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
          format = "{temperatureC}°C {icon}";
          format-icons = [ " " "" "" ];
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
            "default" = [ "" "" ];
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
          format-icons = [ "" "" "" "" "" ];
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
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
          min-height: 18px;
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
          background: ${waybar-style.colorscheme.background};
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
          background-color: ${waybar-style.colorscheme.red};
      }
      #backlight {${waybar-module-default}}
      #battery {${waybar-module-default}}
      #battery.charging {
          color: #ffffff;
          background-color: ${waybar-style.colorscheme.green};
      }
      #battery.warning:not(.charging) {
          background-color: #ffbe61;
          color: black;
      }
      #battery.critical:not(.charging) {
          background-color: ${waybar-style.colorscheme.red};
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
}
