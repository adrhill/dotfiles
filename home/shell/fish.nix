{
  programs.fish = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ll = "ls -l";
      lsa = "ls -lah";
      nixgc = "nix-collect-garbage -d"; # Run GC
      gitamend = "git commit --amend --no-edit";
      gitgraph = "git log --oneline --decorate --graph";
      code = "codium";
    };
  };
}
