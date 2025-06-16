{ config, lib, pkgs, ... }:

{
  imports =
  [

  ];

  sound.enable = false;
  hardware.pulseaudio.enable = false;

  #boot.loader.raspberryPi.firmwareConfig = ''
  #  dtparam=audio=off
  #'';

  services.xserver.enable = false;

}
