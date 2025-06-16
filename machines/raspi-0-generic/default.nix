{ config, lib, pkgs, ... }:

{
  imports =
    [
      #../../profiles/hardening.nix
      #modulesPath + "/installer/scan/not-detected.nix"
      ../../profiles/raspberrypi-0.nix
      ../../profiles/server-generic.nix
      ../../profiles/location/ger.nix
      ../../profiles/language/de.nix

      ../../users/dmo.nixos.nix
      #../../services/home-manager.nix
      ../../profiles/networks/W179.nix

    ];

  # Required for the Wireless firmware
  #hardware.enableRedistributableFirmware = true;


  # File systems configuration for using the installer's partition layout
  fileSystems = {
    # Prior to 19.09, the boot partition was hosted on the smaller first partition
    # Starting with 19.09, the /boot folder is on the main bigger partition.
    # The following is to be used only with older images.
    /*
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };
    */
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  swapDevices = [ ];

  #services.xserver.videoDrivers = [ "fbdev" ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  networking.enableIPv6 = false;

  networking = {
    hostName = "rpi0-nix-test";
  };

  services.xserver = {
    enable = false;
  };

  # compatible NixOS release
  system.stateVersion = "20.09";

  system.autoUpgrade.enable = false;
}
