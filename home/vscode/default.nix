{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      eamodio.gitlens
      usernamehw.errorlens
      gruntfuggly.todo-tree
      github.github-vscode-theme
      bungcip.better-toml
      james-yu.latex-workshop
    ];
  };
}
