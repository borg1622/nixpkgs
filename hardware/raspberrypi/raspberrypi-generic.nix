{ config, lib, pkgs, ... }:

{
  imports =
    [

    ];

    # !!! Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
    # If X.org behaves weirdly (I only saw the cursor) then try increasing this to 256M.
    # On a Raspberry Pi 4 with 4 GB, you should either disable this parameter or increase to at least 64M if you want the USB ports to work.
    #boot.kernelParams = ["cma=32M"];


    boot = {
      #initrd.availableKernelModules = [ "usbhid" ];
      #initrd.kernelModules = [ ];
      #kernelModules = [ ];
      #extraModulePackages = [ ];

      loader = {
          # NixOS wants to enable GRUB by default
          grub.enable = false;

          # Enables the generation of /boot/extlinux/extlinux.conf
          generic-extlinux-compatible.enable = true;

          raspberryPi.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
            #raspberrypi-tools
            libraspberrypi
            f2fs-tools
            ];

}
