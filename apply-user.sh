#!/bin/sh
pushd ~/.dotfiles
nix build .#homeConfigurations.hill.activationPackage
home-manager switch --flake .#hill
popd
