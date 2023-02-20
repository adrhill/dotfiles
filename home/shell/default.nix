{
  imports = [
    # ./zsh.nix
    ./nushell.nix
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
}
