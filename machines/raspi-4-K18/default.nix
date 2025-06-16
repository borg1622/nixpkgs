{ config, lib, pkgs, ... }:

{
  imports =
    [
      #../../profiles/hardening.nix
      #modulesPath + "/installer/scan/not-detected.nix"
      ../../hardware/raspberrypi/raspberrypi-4.nix
      ../../hardware/raspberrypi/raspberrypi-headless.nix
      ../../profiles/location/ger.nix
      ../../profiles/language/de.nix
      ../../profiles/server-generic.nix
      ../../profiles/disable/disable-ipv6.nix
      ../../profiles/disable/disable-x11.nix
      ../../services/acme.nix
      ../../services/baikal.nix
      ../../services/nextcloud.nix
      ../../services/brother.nix
      # ../../services/matrix-synapse.nix
    ];
  
  boot.kernel.sysctl = {
    "vm.swappiness" = 50;
  };

  networking.wireless.enable = false;
  networking.hostName = "HE54-pi";

  users.mutableUsers = true; # todo move to machine config


  # compatible NixOS release
  system.stateVersion = "23.05";

  system.autoUpgrade.enable = lib.mkDefault false;
}
