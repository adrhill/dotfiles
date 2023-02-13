{ ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "nixTheme"; # defined in ./themes
      editor.rulers = [88 120];
    };
    languages = [
      {
        name = "nix";
        auto-format = true;
        indent = { tab-width = 2; unit = " "; };
        language-server = { command = "rnix-lsp"; };
        formatter = { command = "nix fmt"; args = ["-f -"]; }; # read from standard input
      }
    ];
  };    
}
