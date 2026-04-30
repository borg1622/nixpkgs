{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    layout = "de"; # move to localisation nix

    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
      configFile = ../lib/etc/i3.vm.config;
    };

  };

  programs.i3lock.enable = true;
  programs.i3lock.u2fSupport = true;

  #environment = {
    #systemPackages = with pkgs; [
    #  zsh
    #  zsh-powerlevel10k
    #];

  #  etc = {
  #    "i3/config"= {
  #      source = ../lib/etc/i3.vm.config;
  #    };
  #  };
  #};


}
