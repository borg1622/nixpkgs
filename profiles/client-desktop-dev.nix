{ config, pkgs, inputs, ... }:

{

  imports =
  [
    ./client-desktop.nix
  ];


  environment.systemPackages = with pkgs; [
      #veracrypt

      ### NixOS enhancements ###
      nix-prefetch
      nix-prefetch-scripts
      nixops_unstable_minimal

      ### System utilities ###
      pciutils
      lshw
      lshw-gui
      arandr
      fuse      # todo check if necessary
      fusePackages.fuse_2 # todo check if necessary
      glibc       # todo check if necessary
      inotify-tools
      veracrypt
      guvcview    # todo check if necessary

      ### Development ###
      # chromedriver
      # powershell
      vscodium

      # media processing
      optipng
      poppler-utils  # PDF rendering library
      imagemagickBig
      jbig2enc
      gthumb    # Image browser and viewer for GNOME
      # unpaper
      # noteshrink
      # pdfsandwich
      # 

      ### Security ###
      nmap
      wireguard-tools
      trufflehog    # Find credentials all over the place
      netcat
      wireshark
      hashcat
      john
      s6-dns  # todo check if necessary
      dnsx    # todo check if necessary
      iftop   # todo check if necessary
      # truecrack     # Brute-force password cracker for TrueCrypt volumes, optimized for Nvidia Cuda technology

      ### System Management ###
      remmina       # Remote desktop client written in GTK
      #rpi-imager    
      sshfs-fuse
      unetbootin


      ### Other ###
      # ookla-speedtest
      # speedtest-cli
      # httrack
      nextcloud-client
    
      #certbot          # todo: move to server profile
      
  ];

}
