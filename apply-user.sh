#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/hill/home.nix
popd
