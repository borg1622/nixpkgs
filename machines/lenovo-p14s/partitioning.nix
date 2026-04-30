{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/" =
    { device = "rpool/safe/nixos-root";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5d32ce9c-4750-478f-a6c4-b895e2736284";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/96A1-8620";
      fsType = "vfat";
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/d88963fe-d18d-4a4a-b8a7-52d9d25c9d53";
      fsType = "ext4";
    };

  fileSystems."/nix" =
    { device = "rpool/local/nix-store";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "rpool/safe/home";
      fsType = "zfs";
    };

  fileSystems."/data" = 
    { device = "rpool/safe/home/data";
      fsType = "zfs";
    };

  swapDevices = [ ];


}