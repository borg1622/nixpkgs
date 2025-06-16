{ config, pkgs, inputs, pkgs-unstable, ... }:



let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };

  #old = import <nixos-21.11> {
  #  config.allowUnfree = true;
  #};
  unstable-packages = with pkgs-unstable; [
      rpi-imager
      
      lshw
      nmap
      ookla-speedtest
      speedtest-cli
      trufflehog
      #powershell
      chromedriver
      tor-browser-bundle-bin
      wireguard-tools
      httrack
      realvnc-vnc-viewer
      remmina
      hashcat
      vscodium
      nextcloud-client
      
  ];
in
{

  imports =
  [
    ./client-desktop.nix
  ];


  environment.systemPackages = with pkgs; [
      #veracrypt
      pciutils
      rpi-imager
      pciutils
      lshw
      nmap
      ookla-speedtest
      speedtest-cli
      trufflehog
      #powershell
      chromedriver
      tor-browser-bundle-bin
      wireguard-tools
      httrack
      realvnc-vnc-viewer
      remmina
      #certbot
      #realvnc-vnc-viewer
      netcat
      sshfs-fuse
      optipng
      # ocrmypdf  # already defined as python extension
      arandr
      fuse
      fusePackages.fuse_2
      
      nix-prefetch
      nix-prefetch-scripts
      glibc
      # img2pdf # already defined as python extension
      poppler_utils
      imagemagickBig
      jbig2enc
      inotify-tools
      unpaper
      noteshrink
      pdfsandwich
      wireshark

      john

      hashcat
      john
      vscodium
      nextcloud-client
      veracrypt
      unetbootin
      gthumb
      # pdfminer # already defined as python extension
      s6-dns
      dnsx
      iftop
      guvcview
      # input-utils # unmaintained, but useful
      nixops_unstable_minimal
  ] ++ unstable-packages;

  #nixops_unstable_minimal.withPlugins (ps: [ ps.nixops-gce ps.nixops-encrypted-links ])

}
