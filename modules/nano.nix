{ config, inputs, pkgs-unstable, pkgs, ... }:


<<<<<<< HEAD
=======

let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };

in
>>>>>>> flake-conversion
{

  imports =
  [

  ];

  programs.nano.syntaxHighlight = true;
  programs.nano.nanorc = ''
    set nowrap
    set tabstospaces
    set tabsize 2
    set autoindent
    set constantshow
    set indicator
    set linenumbers
    set positionlog
  '';

<<<<<<< HEAD
  environment.systemPackages = with pkgs-unstable; [
=======
  environment.systemPackages = with pkgs; [
    # unstable.nano
>>>>>>> flake-conversion
    nano
  ];

}
