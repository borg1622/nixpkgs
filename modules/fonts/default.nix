{ config, pkgs, ... }:

{
  # fonts = {
  #   #enableDefaultFonts = true;
  #   enableFontDir = true;
  #   #fontDir.enable = true;

  #   fonts = with pkgs; [
  #     (nerdfonts.override {
  #       fonts = [ "DejaVuSansMono" "InconsolataLGC"]; #"Meslo"
  #       })
  #     open-sans
  #     dejavu_fonts
  #     libertine
  #     font-awesome
  #   ];

  #   fontconfig = {
  #     enable = true;
  #     #antialias = true;
  #     #hinting.enable = true;
  #     defaultFonts = {
  #       monospace = [ "DejaVuSansMono Nerd Font Mono Book" ];
  #       serif = [ "Linux Libertine" ];
  #       sansSerif = [ "DejaVu Sans" ];
  #       #emoji = [ "Twitter Color Emoji" ];
  #     };
  #   };
  # };

  fonts.packages = with pkgs; [
    terminus_font
    nerd-fonts.terminess-ttf
    #twemoji-color-font # Desktops only
    #liberation_ttf # Desktops only
    #noto-fonts # Desktops only
  ];

  console = {
    #font = "Lat2-Terminus16";
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  };
}
