{ config, pkgs, inputs, pkgs-unstable, ... }:



let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  #   config.permittedInsecurePackages = [ 
  #     pkgs.lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0"
  #    # "electron-25.9.0"
  #   ];
  # };

  unstable-packages = with pkgs-unstable; [
      pdfsam-basic
      thunderbird
      obsidian
      #pdfmixtool
      solo2-cli
      josm
      anki-bin
      joplin-desktop
      gimp
      #teams
      #teams
      appimagekit
      keepassxc
      gnomeExtensions.nextcloud-folder
      usbutils
      imv
      qiv
      xplr

      nnn
  ];

in
{

  imports =
  [
      ./system-generic.nix
      ../modules/fonts/desktop.nix
      ../modules/i3.nix
      ../modules/v4l2.nix
      ../modules/python.nix
      ../modules/yubikey.nix
      ../modules/keyboard-kinesis.nix
      # ../users/user.desktop.nix
  ];

  users.users.dmo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "vboxusers"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  programs.java = { enable = true; };

  
  environment.sessionVariables.TERMINAL = [ "terminator" ];

  programs.sway = {
    enable = false; #true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      dmenu # Dmenu is the default in the config but i recommend wofi since its wayland native
      wofi
    ];
  };

  networking.networkmanager.ensureProfiles.profiles = {
    "38C3" = {
      connection = {
        id = "38C3";
        uuid = "c80101e2-7b99-4511-846b-2388eb86a5ad";
        type = "wifi";
      }; 
      wifi = {
        mode = "infrastructure";
        ssid = "38C3";
      };
      wifi-security = {
        auth-alg = "open";
        key-mgtm = "wpa-eap";
      };
      "802-1x" = {
        altsubject-matches = "DNS:radius.c3noc.net";
        ca-cert = "/etc/ssl/certs/ca-certificates.crt";
        eap = "ttls";
        identity = "outboundonly";
        password = "outboundonly";
        phase2-auth = "pap";
      };
      ipv4.method = "auto";
      ipv6.method = "auto";      

    };

  };

  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
    wifi.scanRandMacAddress = true;

    
  };
  networking.dhcpcd.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  #networking.useDHCP = false;

  services.logind.extraConfig = ''
    IdleAction=lock
    IdleActionSec=1800
    HandlePowerKey=suspend
  '';

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="kbd_backlight", GROUP="video", MODE="0664"
  '';

      #joplin-desktop
  services.picom = {  # window composer, necessary to remove black borders in i3wm
    enable = true;
    backend = "glx";

  };

  environment.systemPackages = with pkgs; [
      czkawka
      dupeguru
      
      pdfsam-basic
      thunderbird
      obsidian
      #pdfmixtool
      solo2-cli
      josm
      anki-bin
      joplin-desktop
      szyszka
      exiftool
      #audacity
      ffmpeg
      notify
      firefox
      google-chrome
      appimage-run
      #zoom-us
      filezilla

      vlc
      rapid-photo-downloader
      gimp
      #teams
      #teams
      
      keepassxc
      vlc
      rapid-photo-downloader
      # gnomeExtensions.nextcloud-folder  # removed in NixOS 25.05
      digikam
      qpdfview
      bc
      #anydesk
      fuse # needed for AppImage (Joplin, Obsidian, ..)
      nss_latest # required libssl3 / by some firefox functionality
      
      #unstable.obs-studio
      #unstable.droidcam
      unrar

      #obs-studio
      #droidcam
      usbutils
      unrar
      imv
      qiv
      xsettingsd
      xorg.xrdb
      
      killall 
      woeusb
      unetbootin
      
      nfs-utils    
          
      xorg.xf86videoamdgpu
      xorg.xf86inputevdev
      koreader
      actkbd
      curlFull
      
      deer
      terminator

      nnn
      ranger
      ueberzug
      gpxlab
      xorg.xdpyinfo
      # topgrade
      gparted
      wirelesstools
      bitwarden-desktop
      xorg.xev
#      cryptomator      
      iw # iwconfig replacement
      ripgrep-all
      xplr
  ] ++ unstable-packages;

}
