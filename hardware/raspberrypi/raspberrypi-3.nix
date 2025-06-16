{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ 
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  swapDevices = [ ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  networking.interfaces.enu1u1.useDHCP = lib.mkDefault true;
  networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  boot = {
    loader = {
      # NixOS wants to enable GRUB by default
      grub.enable = false;
      # Enables the generation of /boot/extlinux/extlinux.conf
      generic-extlinux-compatible.enable = true;
      # depricated / will be removed from NixOS 24.11 onwards
      raspberryPi.version = 3;
    };
    # Mainline doesn't work yet
    kernelPackages = pkgs.linuxPackages_rpi3;

    # ttyAMA0 is the serial console broken out to the GPIO
    #kernelParams = [
    #  "8250.nr_uarts=1" # may be required only when using u-boot
    #  "console=ttyAMA0,115200"
    #  "console=tty1"
    #];
  };

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;
  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    #raspberrypifw
  ];
}

