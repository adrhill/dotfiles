{ pkgs, config, ... }:

let
  inherit (config.colorscheme) colors;

in
{
  imports = [
    ./fish.nix
  ];

  programs.zoxide = { enable = true; };
  programs.direnv = { enable = true; };
  programs.keychain = { enable = true; };
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "base16";
      themes = {
        base16 = {
          fg = "#FFFFFF";
          bg = "#${colors.base00}";
          black = "#000000";
          red = "#${colors.base08}";
          green = "#${colors.base0B}";
          yellow = "#${colors.base0A}";
          blue = "#${colors.base0D}";
          magenta = "#${colors.base0E}";
          cyan = "#${colors.base0C}";
          white = "#FFFFFF";
          orange = "#${colors.base09}";
        };
      };
    };
  };
}
