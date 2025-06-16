{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
in
{
  virtualisation.docker.enable = true;


  environment.systemPackages = with pkgs; [

  ];

}
