{ config, pkgs, ... }:

{

  fonts.packages = with pkgs; [
    terminus_font
    nerd-fonts.terminess-ttf

  ];

  console = {
    #font = "Lat2-Terminus16";
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  };
}
