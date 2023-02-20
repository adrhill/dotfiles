{
  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ll = "ls -l";
      nixgc = "nix-collect-garbage -d"; # Run GC
      gitgraph = "git log --oneline --decorate --graph";
      code = "codium";
    };
    history.size = 20000;
    #autosuggestions.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "history"
        "copyfile"
        "copypath"
        "sudo"
        "web-search"
        "poetry"
      ];
    };
  };
}
