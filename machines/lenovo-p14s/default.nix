# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, outputs, lib, config, pkgs, callPackage, ... }:

# let
#   unstable = import <nixos-unstable> {
#     config.allowUnfree = true;
#   };

# in
{
  imports =
    [
      ../../hardware/lenovo/p14s_gen2.nix
      ./hardware-configuration.nix
      ./lenovo-backlight.nix
      ../../profiles/language/en.nix
      ../../profiles/location/ger.nix
      ../../profiles/client-desktop-dev.nix
      ../../modules/printing.nix
      ../../modules/virtualbox.nix
      ../../services/network-wifi-lan-toggle.nix
    ];

  # nix = {
  #   package = pkgs.nixFlakes;
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };
  # For support of newer AMD GPUs, backlight and internal microphone
  #boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.13") pkgs.linuxPackages_latest;

  # nix.extraOptions = ''
  #   experimental-features = nix-command flakes
  # '';

  # nixpkgs = {
  #   overlays = [
  #     # Add overlays your own flake exports (from overlays and pkgs dir):
  #     outputs.overlays.additions
  #     outputs.overlays.modifications
  #     outputs.overlays.unstable-packages

  #     # You can also add overlays exported from other flakes:
  #     # neovim-nightly-overlay.overlays.default

  #     # Or define it inline, for example:
  #     # (final: prev: {
  #     #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     #     patches = [ ./change-hello-to-hi.patch ];
  #     #   });
  #     # })
  #   ];
  #   # Configure your nixpkgs instance
  #   config = {
  #     # Disable if you don't want unfree packages
  #     allowUnfree = true;
  #   };

  #   # config.permittedInsecurePackages = [
  #   #   "python3.10-requests-2.28.2"
  #   #   "python3.10-cryptography-40.0.1"
  #   # ];
  # };

  # nix = let
  #   flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  # in {
  #   settings = {
  #     # Enable flakes and new 'nix' command
  #     experimental-features = "nix-command flakes";
  #     # Opinionated: disable global registry
  #     flake-registry = "";
  #     # Workaround for https://github.com/NixOS/nix/issues/9574
  #     nix-path = config.nix.nixPath;
  #   };
  #   # Opinionated: disable channels
  #   channel.enable = false;

  #   # Opinionated: make flake registry and nix path match flake inputs
  #   registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
  #   nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  # };

  

  #console.useXkbConfig = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpilight
    #unstable.zsh-powerlevel10k
    #solaar
    #tlp # advanced power management for linux
      #     unstable.prospector
  #   unstable.pipenv
  #   unstable.direnv
  ];

   # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
