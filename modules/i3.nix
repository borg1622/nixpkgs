{ config, pkgs, inputs, ... }:

let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };

in
{


    environment.etc = {
      "i3/bsod.png" = {
        mode = "0444";
        source = ../lib/etc/bsod-2.png;
      };
    };
    
    # todo: improve handling of suspend/resume
    # https://nixos.wiki/wiki/Power_Management
    # https://gist.github.com/victorhaggqvist/603125bbc0f61a787d89
    # https://superuser.com/questions/1743667/activating-lockscreen-using-systemd-doesnt-work
    # https://discourse.nixos.org/t/how-to-add-a-file-to-pkgs-systemd-lib-systemd-system-sleep/2775/3
    # https://github.com/NixOS/nixpkgs/pull/5162

    # https://dev.to/ccoveille/i3lock-vs-dunst-h98
    environment.etc = {     
     "i3/lock.sh" = {
        mode = "0555";
        text = ''
          #!/bin/sh

          BLANK="000000"

          echo "''${BLANK}"
          i3params="\
            --image /etc/i3/bsod.png  \
            --color=''${BLANK}        \
            --blur 10                 \
            "
          # --no-unlock-indicator     \


          while getopts l: flag
          do
            case "''${flag}" in
              s) SUSPEND='1' ;;
            esac
          done

          if [ -n ''${SUSPEND} ]
          then
            echo "SUSPEND"
            i3lock ''${i3params}
          else            
            trap "dunstctl set-paused false" EXIT
            dunstctl set-paused true
            echo "i3lock ''${i3params} --nofork"
            i3lock ''${i3params} --nofork
          fi
      '';
     };
   };

  services.displayManager.defaultSession = "none+i3";

  programs.i3lock.enable = true;
  programs.i3lock.u2fSupport = true;

  services = {
    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;


  };

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;

    # layout = "de"; # todo: move to localisation nix

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        # i3lock
        i3lock-color
        #polybarFull
        rofi
        rofi-calc
        rofi-systemd
      ];

      configFile = ../lib/etc/i3.config;
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    #  baobab      # disk usage analyzer
    cheese # photo booth
    eog # image viewer
    epiphany # web browser
    #  gedit       # text editor
    simple-scan # document scanner
    totem # video player
    yelp # help viewer
    #  evince      # document viewer
    #  file-roller # archive manager
    geary # email client
    seahorse # password manager

    # these should be self explanatory
    #  gnome-calculator 
    # gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    # gnome-photos
    # pkgs.gnome-photos
    gnome-screenshot
    # gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    # pkgs.gnome-connections
  ];
  services.gnome.gnome-keyring.enable = true;
  services.gnome.sushi.enable = true;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    volctl
    pavucontrol
    #udiskie
    libnotify
    gobject-introspection # required by rapidphotodownloader
    dmenu
    networkmanager
    networkmanager_dmenu
    networkmanagerapplet
    
    
    xorg.xrandr
    xorg.xprop
    nemo        # File browser for Cinnamon
    pasystray
    gnome-tweaks
    dconf-editor
    gnome-control-center
    # unstable.xdotool
    xdotool
    
  ];


}
