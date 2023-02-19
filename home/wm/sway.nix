{ pkgs, lib, config, ... }:

let
  inherit (config) colorscheme wallpaper;

in
{
  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    config = rec {
      modifier = "Mod4";
      workspaceAutoBackAndForth = true;
      terminal = "kitty";
      menu = "wofi --show run";
      bars = [ ];
      gaps = {
        inner = 8;
        outer = -3; # inner is added to this
        smartBorders = "on";
        smartGaps = true;
      };
      window.border = 2;
      colors = {
        background = "#${colorscheme.colors.base00}";
        focused = {
          background = "#${colorscheme.colors.base0A}"; # yellow
          border = "#${colorscheme.colors.base0A}";
          childBorder = "#${colorscheme.colors.base0A}";
          indicator = "#${colorscheme.colors.base0C}";
          text = "#${colorscheme.colors.base00}";
        };
        unfocused = {
          background = "#${colorscheme.colors.base00}";
          border = "#${colorscheme.colors.base00}";
          childBorder = "#${colorscheme.colors.base00}";
          indicator = "#${colorscheme.colors.base00}";
          text = "#${colorscheme.colors.base00}";
        };
      };
      fonts = {
        names = [ "Julia Mono" ];
        style = "Medium";
        size = 11.0;
      };
      startup = [
        { command = "waybar"; }
        { command = "sworkstyle"; }
        { command = "swaybg -i ${wallpaper} --mode fill"; }
      ];
      # assigns = {
      #   "2" = [{ app_id = "firefox"; }];
      #   "3" = [{ app_id = "telegram-desktop"; }];
      # };
      input = {
        # Options applied to built in ThinkPad keyboard:
        "type:keyboard" = {
          xkb_options = "caps:escape,compose:rwin,ctrl:swap_lalt_lctl";
        };
        # Options applied to Apple Magic Keyboard
        "76:615:Adrian_Hill___s_Keyboard" = {
          xkb_options = "caps:escape,compose:rwin,altwin:swap_lalt_lwin";
        };
        # Options applied to all touchpads
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.5";
        };
      };
      output = {
        # DPI settings for each output device:
        eDP-1.scale = "1.2";
        HDMI-A-1.scale = "1.2";
      };
      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 -5%";
        "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 toggle";
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";
        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";
      };
    };
    extraOptions = [
      "--unsupported-gpu" # NVIDIA drivers
    ];
  };
}
