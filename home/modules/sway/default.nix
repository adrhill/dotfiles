{ pkgs, lib, config, ... }:

let
  inherit (config) colorscheme wallpaper;

in
{
  imports = [ ./waybar.nix ];

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi --show run";
      bars = [ ];
      gaps = {
        inner = 8;
        outer = 1;
        smartBorders = "on";
        smartGaps = true;
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
        "type:keyboard" = {
          xkb_options = "caps:escape,ctrl:swap_lalt_lctl";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.5";
        };
      };
      # output = {
      #   "*" = {
      #     "bg" = "/home/hill/.background-image fill";
      #   };
      # };
      keybindings = lib.mkOptionDefault {
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
}
