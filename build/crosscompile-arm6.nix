{ pkgs, config, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-raspberrypi.nix>
    ../machines/raspi-0-generic/default.nix
  ];

  # set cross compiling
  nixpkgs.crossSystem = lib.systems.elaborate lib.systems.examples.raspberryPi;

  boot.binfmt.emulatedSystems = [ "armv6l-linux" ];


}
