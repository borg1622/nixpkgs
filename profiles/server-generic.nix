{ config, pkgs, ... }:
{

  imports =
  [
      ./system-generic.nix
      ../services/kitty.nix
      ../services/ssh-server.nix
      ../users/user.server.nix
      ../modules/fonts
      ../modules/sudo.server.nix
  ];

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 180d";
  };

  system.autoUpgrade = {
    enable = true;
    dates = "Fri *-*-* 01:00:00"; # weekly on friday at 01:00:00 AM
    randomizedDelaySec = "1h";
    allowReboot = true;
    rebootWindow = {
      lower = "02:00";
      upper = "05:00";
    };
  };

  environment.systemPackages = with pkgs; [
    google-authenticator
  ];

}
