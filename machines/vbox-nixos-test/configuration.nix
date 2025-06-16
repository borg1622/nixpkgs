{ config, lib, pkgs, ... }:

{
  imports =
    [
      #<nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
      <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix>
      <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
      #<nixpkgs/nixos/modules/profiles/clone-config.nix>
      #<nixpkgs/nixos/modules/installer/virtualbox-demo.nix>
      #../../profiles/hardening.nix
      ../../profiles/client-generic.nix
      ../../profiles/location/ger.nix
      ../../profiles/language/de.nix
      ../../profiles/networks/virtualbox-guest-static.nix

      ../../users/dmo.vm.nix
      ../../services/ssh-server.nix
      #../../services/home-manager.nix

    ];

  # FIXME: UUID detection is currently broken
  boot.loader.grub.fsIdentifier = "provided";

  # Add some more video drivers to give X11 a shot at working in
  # VMware and QEMU.
  services.xserver.videoDrivers = [ "virtualbox" "vmware" "cirrus" "vesa" "modesetting" ];

  powerManagement.enable = false;

  #installer.cloneConfigExtra = ''
    # Let demo build as a trusted user.
    # nix.trustedUsers = [ "demo" ];
    # Mount a VirtualBox shared folder.
    # This is configurable in the VirtualBox menu at
    # Machine / Settings / Shared Folders.
    # fileSystems."/mnt" = {
    #   fsType = "vboxsf";
    #   device = "nameofdevicetomount";
    #   options = [ "rw" ];
    # };
  #'';


  services.xserver = {
    enable = true;
    libinput.enable = true; # for touchpad support on many laptops
    desktopManager.plasma5.enable = false;

    displayManager = {
      autoLogin = {
        enable = true;
        user = "dmo";
      };
      sddm.enable = false;
    };
  };

  # Enable sound in virtualbox appliances.
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
      glxinfo
      firefox
      zfs
      linuxPackages.zfs
      ];


  networking = {
    hostName = "virtbx-nix-test";
  };

  # compatible NixOS release
  system.stateVersion = "20.09";

  system.autoUpgrade.enable = false;
}
