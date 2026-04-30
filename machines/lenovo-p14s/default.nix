# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# todo: https://github.com/reckenrode/nixos-configs/blob/main/hosts/josette/configuration.nix

{ inputs, outputs, lib, config, pkgs, callPackage, ... }:

# let
#   unstable = import <nixos-unstable> {
#     config.allowUnfree = true;
#   };

# in
{
  imports =
    [
      # machine independent hardware configuration
      ../../hardware/lenovo/p14s_gen2.nix
      ../../hardware/logitech-wireless.nix
      ./lenovo-backlight.nix                  # todo: fix script, doesn't work # enable brightness control buttons

      # specific hardware configuration for this machine 
      ./hardware-configuration.nix
      ./partitioning.nix
      ./networking.nix
      
      # set language and timezone
      ../../profiles/language/en.nix
      ../../profiles/location/ger.nix

      # load machine usage profile
      ../../profiles/client-desktop-dev.nix

      # load additional modules / services
      ../../modules/printing.nix              # todo not properly working - fix this
      ../../modules/virtualbox.nix            # todo replace this by virt-manager -> https://nixos.wiki/wiki/Virt-manager
      ../../services/network-wifi-lan-toggle.nix    # network manager auto toggling between wired and wireless networks

      # specify users
      ../../users/user.desktop.nix
    ];


  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  #console.useXkbConfig = true;               # todo ?

  environment.systemPackages = with pkgs; [

  ];

   # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
