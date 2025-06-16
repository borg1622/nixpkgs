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

  # Enable CUPS to print documents.
  # services.printing.enable = true;


  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix pkgs.samsung-unified-linux-driver ];

  environment.systemPackages = with pkgs; [
    system-config-printer # Graphical user interface for CUPS administration 
  ];

}
