{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./raspberrypi-generic.nix
    ];

    boot = {
      loader.raspberryPi.version = 0;
      # Mainline doesn't work yet
      #kernelPackages = pkgs.linuxPackages_rpi4;
      kernelPackages = pkgs.linuxPackages_rpi0;

      # ttyAMA0 is the serial console broken out to the GPIO
      kernelParams = [
        "console=ttyAMA0,115200"
        "console=tty1"
        "cma=32M"
      ];
    };

    nix.binaryCaches = lib.mkForce [ "https://app.cachix.org/cache/thefloweringash-armv7" ];
    nix.binaryCachePublicKeys = [ "thefloweringash-armv7.cachix.org-1:v+5yzBD2odFKeXbmC+OPWVqx4WVoIVO6UXgnSAWFtso=" ];

    #powerManagement.enable = true;
    #powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

    environment.systemPackages = with pkgs; [
      wirelesstools
      wpa_supplicant
      dhcp
    ];

    hardware.firmware = with pkgs; [
      raspberrypiWirelessFirmware
    ];
}
