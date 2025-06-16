{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };

in
{
  
  boot.extraModulePackages = with unstable; [
    config.boot.kernelPackages.v4l2loopback
  ];
  # Register a v4l2loopback device at boot
  boot.kernelModules = [
    "v4l2loopback"
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1
  '';

  environment.systemPackages = with pkgs; [
    linuxPackages.v4l2loopback
  ];
}
