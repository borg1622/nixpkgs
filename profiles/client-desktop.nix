{ config, pkgs, inputs, ... }:


{

  imports =
  [
      ./system-generic.nix
      ../modules/fonts/desktop.nix
      ../modules/i3.nix
      # ../modules/v4l2.nix   # streaming / video conferencing
      ../modules/python.nix
      ../modules/yubikey.nix
      ../modules/keyboard-kinesis.nix
      # ../users/user.desktop.nix
  ];


  
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


  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
    wifi.scanRandMacAddress = true;   
  };

  networking.dhcpcd.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  #networking.useDHCP = false;

  services.logind.settings.Login = {
    IdleAction = "lock";
    IdleActionSec = 1800;
    HandlePowerKey = "suspend";
  };


  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="kbd_backlight", GROUP="video", MODE="0664"
  '';

      #joplin-desktop
  services.picom = {  # window composer, necessary to remove black borders in i3wm
    enable = true;
    backend = "glx";
  };

  environment.systemPackages = with pkgs; [

      ### System utilities ###
      usbutils
      czkawka # Simple, fast and easy to use app to remove unnecessary files from your computer
      dupeguru
      xplr    # Hackable, minimal, fast TUI file explorer
      nnn     # Small ncurses-based file browser forked from noice
      solo2-cli   # CLI tool for managing SoloKeys' Solo2 USB security keys
      szyszka   # Simple but powerful and fast bulk file renamer
      notify
      appimage-run
      bc      # GNU software calculator
      fuse # needed for AppImage (Joplin, Obsidian, ..)
      nss_latest # required libssl3 / by some firefox functionality
      unrar
      xsettingsd  # todo check if necessary
      xorg.xrdb   # todo check if necessary
      psmisc
      nfs-utils   
      xorg.xf86videoamdgpu  # todo check if necessary
      xorg.xf86inputevdev   # todo check if necessary
      actkbd   # todo check if necessary
      curlFull
      deer
      terminator
      ranger
      ueberzug
      xorg.xdpyinfo
      # topgrade
      gparted
      wirelesstools  # todo check if necessary
      xorg.xev
      iw # iwconfig replacement
      ripgrep-all   # Ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, and more
      autorandr
      gedit
      protonmail-export
      hwinfo
      #code-cursor

      ### media processing ###
      imv     # Command line image viewer for tiling window managers
      qiv     # Quick image viewer
      pdfsam-basic
      #pdfmixtool
      #audacity
      exiftool
      ffmpeg
      vlc
      rapid-photo-downloader
      gimp
      digikam
      qpdfview
      #obs-studio
      #droidcam
      gpxlab
      scrot


      ### office ### 
      thunderbird
      protonmail-desktop   
      obsidian
      josm
      #anki-bin
      joplin-desktop
      firefox
      google-chrome
      keepassxc
      koreader
      bitwarden-desktop
      cryptomator

      #teams
      #zoom-us
      #anydesk

      filezilla
      woeusb    # Create bootable USB disks from Windows ISO images
            
  ];

}
