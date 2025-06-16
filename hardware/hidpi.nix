{ config, pkgs, ... }:



let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };

in
{

  imports =
  [

  ];


  environment.etc = {
    "xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-icon-theme-name=Papirus
        gtk-theme-name=Adapta
        gtk-cursor-theme-name=Adwaita
        gtk-cursor-theme-size=48
      '';
      mode = "444";
    };
    "xdg/gtk-3.0/gtk.css" = {
      text = ''
          window decoration {
              box-shadow: none;
              margin: 1px;
          }
      '';
      mode = "444";
    };
  };
  
  services.xserver = {
    dpi = 220;
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
        Xcursor.theme: Adwaita
        Xcursor.size: 48
        Xft.dpi: 192
      EOF
    '';
    displayManager.importedVariables = [
      "GDK_SCALE"
      "GDK_DPI_SCALE"
      "QT_AUTO_SCREEN_SCALE_FACTOR"
    ];
  };

  environment.variables = {
    GDK_SCALE = "1"; # 2
    GDK_DPI_SCALE = "1"; # 0.5
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };

  environment.systemPackages = with pkgs; [
  
      
  ];

}
