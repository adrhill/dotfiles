{ config, ... }:

let
  inherit (config.colorscheme) colors;
  starshipCmd = "${config.home.profileDirectory}/bin/starship";
  zoxideCmd = "${config.home.profileDirectory}/bin/zoxide";

in
{
  programs.nushell = {
    enable = true;

    extraEnv = ''        
      let starship_cache = "${config.xdg.cacheHome}/starship"
      if not ($starship_cache | path exists) {
        mkdir $starship_cache
      }
      ${starshipCmd} init nu | save --force ${config.xdg.cacheHome}/starship/init.nu
      ${zoxideCmd} init nushell | save -f ${config.xdg.cacheHome}/zoxide.nu
      let-env EDITOR = "hx"

      # Config for Starship
      let-env STARSHIP_SHELL = "nu"
      def create_left_prompt [] {
          starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
      }
      # Use nushell functions to define your right and left prompt
      let-env PROMPT_COMMAND = { create_left_prompt }
      let-env PROMPT_COMMAND_RIGHT = ""

      # The prompt indicators are environmental variables that represent the state of the prompt
      let-env PROMPT_INDICATOR = ""
      let-env PROMPT_INDICATOR_VI_INSERT = ": "
      let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
      let-env PROMPT_MULTILINE_INDICATOR = "::: "
    '';

    extraConfig = ''        
      source ${config.xdg.cacheHome}/starship/init.nu
      source ${config.xdg.cacheHome}/zoxide.nu

      alias la = ls -a
      alias ll = ls -l
      alias nixgc = nix-collect-garbage -d
      alias gitgraph = git log --oneline --decorate --graph
      alias code = codium

      let base00 = "#${colors.base00}"
      let base01 = "#${colors.base01}"
      let base02 = "#${colors.base02}"
      let base03 = "#${colors.base03}"
      let base04 = "#${colors.base04}"
      let base05 = "#${colors.base05}"
      let base06 = "#${colors.base06}"
      let base07 = "#${colors.base07}"
      let base08 = "#${colors.base08}"
      let base09 = "#${colors.base09}"
      let base0a = "#${colors.base0A}"
      let base0b = "#${colors.base0B}"
      let base0c = "#${colors.base0C}"
      let base0d = "#${colors.base0D}"
      let base0e = "#${colors.base0E}"
      let base0f = "#${colors.base0F}"
   
      let base16_theme = {
          separator: $base03
          leading_trailing_space_bg: $base04
          header: $base0b
          date: $base0e
          filesize: $base0d
          row_index: $base0c
          bool: $base08
          int: $base0b
          duration: $base08
          range: $base08
          float: $base08
          string: $base04
          nothing: $base08
          binary: $base08
          cellpath: $base08
          hints: dark_gray

          # shape_garbage: { fg: $base07 bg: $base08 attr: b} # base16 white on red
          # but i like the regular white on red for parse errors
          shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
          shape_bool: $base0d
          shape_int: { fg: $base0e attr: b}
          shape_float: { fg: $base0e attr: b}
          shape_range: { fg: $base0a attr: b}
          shape_internalcall: { fg: $base0c attr: b}
          shape_external: $base0c
          shape_externalarg: { fg: $base0b attr: b}
          shape_literal: $base0d
          shape_operator: $base0a
          shape_signature: { fg: $base0b attr: b}
          shape_string: $base0b
          shape_filepath: $base0d
          shape_globpattern: { fg: $base0d attr: b}
          shape_variable: $base0e
          shape_flag: { fg: $base0d attr: b}
          shape_custom: {attr: b}
      }

      let-env config = {
        edit_mode: vi
        show_banner: false  
        shell_integration: true
        color_config: $base16_theme
        history: {
          max_size: 100000 # Session has to be reloaded for this to take effect
          sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
          file_format: "plaintext" # "sqlite" or "plaintext"
        }
      }
    '';
  };
}
