{ config, lib, pkgs, ... }:

{
  imports =
    [
        # Include the results of the hardware scan.
      #<nixos-hardware/lenovo/thinkpad/p14s/amd/gen2>
      # <nixos-hardware/common/pc/laptop/acpi_call.nix>
      # <nixos-hardware/common/cpu/amd>
      # <nixos-hardware/common/gpu/amd>
      ./tlp.nix
      ./touchpad.nix
      ../hidpi.nix
    ];


    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    # networking.useDHCP = lib.mkDefault true;
    networking.interfaces.enp2s0f0.useDHCP = lib.mkDefault true;
    networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
    networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;
      
    #   boot.kernelParams = lib.mkOverride 999 (builtins.filter (p: p != "amdgpu.backlight=0" || p != "acpi_backlight=none") config.boot.kernelParams);
    #   boot.kernelParams = lib.mkOverride 999 (builtins.filter (p: p != "nohibernate") config.boot.kernelParams);
    boot.kernelParams = [];
    boot.initrd.kernelModules = [ "amdgpu" ];
    
    services.xserver =
    {
      videoDrivers = [ "amdgpu" ];
      synaptics = 
      {
        palmDetect = true;
        maxSpeed = "3.0";
        accelFactor = "0.1";
      };
    }; 

    services.acpid.enable = true;

    services.pulseaudio.enable = false;         # todo: why ?

    # Set your system kind (needed for flakes)
    nixpkgs.hostPlatform = "x86_64-linux";

    environment.systemPackages = with pkgs; [
      acpilight                                 # todo - move to lenovo backlight ?
    ];
}
