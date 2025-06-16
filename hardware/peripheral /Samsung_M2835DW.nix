{ config, pkgs, ... }:



let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };

in
{

  imports =
  [

  ];

  services.printing.enable = true;


  environment.systemPackages = with pkgs; [
    system-config-printer # Graphical user interface for CUPS administration 
  ];

}
