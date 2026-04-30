{ config, inputs, pkgs, ... }:



let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };

in
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

  environment.systemPackages = with pkgs; [
    nano
  ];

}
