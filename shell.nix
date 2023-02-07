
{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "nixosbuildshell";
  nativeBuildInputs = with pkgs; [
    git
    nixFlakes
  ];

  shellHook = ''
      echo "You can apply this flake to your system with nixos-rebuild switch --flake .#"
    '';
  }