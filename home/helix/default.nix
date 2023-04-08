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
      editor = {
        soft-wrap.enable = true;
        rulers = [ 88 120 ];
        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };
      };
    };
    languages = [
      {
        name = "nix";
        auto-format = true;
        indent = { tab-width = 2; unit = " "; };
        language-server = { command = "rnix-lsp"; };
        formatter = { command = "nix fmt"; args = [ "-f -" ]; }; # read from standard input
      } # end Nix
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
      } # end Julia
      {
        name = "rust";
        scope = "source.rust";
        file-types = [ "rs" ];
        roots = [ "Cargo.toml" "Cargo.lock" ];
        auto-format = true;
        comment-token = "//";
        language-server = {
          command = "rust-analyzer";
        };
        config = {
          check.command = "clippy";
          cachePriming.enable = false;
          diagnostics.experimental.enable = true;
          inlayHints = {
            bindingModeHints.enable = false;
            closingBraceHints.minLines = 10;
            closureReturnTypeHints.enable = "with_block";
            discriminantHints.enable = "fieldless";
            lifetimeElisionHints.enable = "skip_trivial";
            typeHints.hideClosureInitialization = false;
          };
        };
      } # end Rust
    ]; # end languages
  };
}

