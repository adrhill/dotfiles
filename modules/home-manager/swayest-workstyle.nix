{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.swayest-workstyle;
  tomlFormat = pkgs.formats.toml { };
in
{
  options.programs.swayest-workstyle = {
    enable = mkEnableOption "Swayest Workstyle";

    package = mkOption {
      type = types.package;
      default = pkgs.swayest-workstyle;
      defaultText = literalExpression "pkgs.swayest-workstyle";
      description = "The package to use for Swayest Workstyle.";
    };

    settings = mkOption {
      type = tomlFormat.type;
      default =
        { };
      example = literalExpression ''
        {
          fallback = "";
          matching = {
            "discord" = "";
            "WebCord" = "";
            "Steam" = "";
            "vlc" = "";
            "pavucontrol" = "";
            "org.gnome.Nautilus" = "";
            "eog" = "";
            "org.qbittorrent.qBittorrent" = "";
            "Thunderbird" = "";
            "thunderbird" = "";
            "Postman" = "";
            "Insomnia" = "";
            "Bitwarden" = "";
            "Google-chrome" = "";
            "Chromium" = "";
            "Slack" = "";
            "Code" = "";
            "code-oss" = "";
            "Emacs" = "";
            "jetbrains-studio" = "";
            "transmission-remote-gtk" = "";
            "Spotify" = "";
            "GitHub Desktop" = "";
            "/(?i)^Github.*Firefox/" = "";
            "firefox" = "";
            "Nightly" = "";
            "firefoxdeveloperedition" = "";
            "/npm/" = "";
            "/node/" = "";
            "/yarn/" = "";
            "Alacritty" = "";
            "foot" = "";
          };
        }
      '';
      description = ''
        Configuration written to
        <filename>$XDG_CONFIG_HOME/sworkstyle/config.toml</filename>.
        </para><para>
        See <link xlink:href="https://github.com/Lyr-7D1h/swayest_workstyle#sworkstyle-configuration"/>
        for the full list of options.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile =
      let
        settings = {
          "sworkstyle/config.toml" = mkIf (cfg.settings != { }) {
            source = tomlFormat.generate "sworkstyle-config" cfg.settings;
          };
        };
      in
      settings;
  };
}
