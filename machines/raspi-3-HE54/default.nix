{ config, lib, pkgs, ... }:

{
  imports =
    [
      #../../profiles/hardening.nix
      #modulesPath + "/installer/scan/not-detected.nix"
      ../../hardware/raspberrypi/raspberrypi-3.nix
      ../../hardware/raspberrypi/raspberrypi-headless.nix
      ../../profiles/location/ger.nix
      ../../profiles/language/de.nix
      ../../profiles/server-generic.nix
      ../../profiles/disable/disable-ipv6.nix
      ../../profiles/disable/disable-x11.nix
    ];

  nixpkgs.localSystem = {
      system = "aarch64-linux";
      config = "aarch64-unknown-linux-gnu";
    };

  networking.wireless.enable = false;

  networking.hostName = "HE54-pi";

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # compatible NixOS release
  system.stateVersion = "23.05";

  system.autoUpgrade.enable = lib.mkDefault false;;
}
