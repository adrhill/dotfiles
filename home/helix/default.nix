{ config, ... }:

let
  inherit (config) colorscheme;


in
{
  programs.helix = {
    enable = true;
    themes = import ./theme.nix { inherit colorscheme; };
    settings = {
      theme = "${colorscheme.slug}";
      editor.rulers = [ 88 120 ];
    };
    languages = [
      {
        name = "nix";
        auto-format = true;
        indent = { tab-width = 2; unit = " "; };
        language-server = { command = "rnix-lsp"; };
        formatter = { command = "nix fmt"; args = [ "-f -" ]; }; # read from standard input
      }
      {
        name = "julia";
        scope = "source.julia";
        file-types = [ "jl" ];
        roots = [ "Manifest.toml" "Project.toml" ];
        language-server = {
          command = "julia";
          timeout = 60;
          args = [
            "--startup-file=no"
            "--history-file=no"
            "--quiet"
            "-e"
            "using LanguageServer; runserver()"
          ];
        };
      }
    ];
  };
}
