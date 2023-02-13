{ ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "nixTheme"; # defined in ./themes
      editor.rulers = [88 120];
    };
  };    
}
