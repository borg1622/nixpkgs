{ config, pkgs, inputs, ... }:

let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };
in
{
  imports =
    [
      ./default.nix
    ];

  environment = {
    systemPackages = with pkgs; [
      font-manager
    ];

  };

  fonts = {
    packages = with pkgs; [
      ubuntu-classic
      open-sans
      material-icons
      material-design-icons
      font-awesome
      siji
      dejavu_fonts
      meslo-lgs-nf
      font-awesome_4
      inconsolata
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.inconsolata
      nerd-fonts.fira-code
      
      # nerd-fonts.Meslo
      #twemoji-color-font # Desktops only
      #liberation_ttf # Desktops only
      #noto-fonts # Desktops only
    ];

    fontconfig = {
      enable = true;
      #antialias = true;
      #hinting.enable = true;
      defaultFonts = {
        monospace = [ "DejaVuSansMono Nerd Font Mono Book" ];
        serif = [ "Linux Libertine" ];
        sansSerif = [ "DejaVu Sans" ];
        #emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
