{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };

in
{

  imports =
  [
  ];

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 20;
    STOP_CHARGE_THRESH_BAT0 = 80;

    START_CHARGE_THRESH_BAT1 = 20;
    STOP_CHARGE_THRESH_BAT1 = 80;

    RESTORE_THRESHOLDS_ON_BAT = 1;
  };  

  environment.systemPackages = with pkgs; [
      linuxPackages.tp_smapi
      tpacpi-bat
  ];

}
