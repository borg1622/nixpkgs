{ config, pkgs, inputs, pkgs-unstable, ... }:

let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };
<<<<<<< HEAD
  unstable-packages = with pkgs-unstable; [
    # fira-code-nerdfont
    nerd-fonts.fira-code
  ];
=======
>>>>>>> flake-conversion
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
      ubuntu_font_family
      open-sans
      material-icons
      material-design-icons
      font-awesome
      ubuntu_font_family
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
    ] ++ unstable-packages;

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
