{ config, pkgs, ... }:



let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };

in
{

  imports =
  [

  ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  #users.extraGroups.vboxusers.members = [ "dmo" ];

  environment.systemPackages = with pkgs; [
    

  ];

}
