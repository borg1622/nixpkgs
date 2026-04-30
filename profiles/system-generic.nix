{ config, pkgs, ... }:


let
  #unstable = import <unstable> {};
in
{

  imports =
  [
    #../services/ohmyzsh.nix
    ../modules/zsh.nix
    ../modules/nano.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nix;   # todo check if necessary
  #nix.extraOptions = ''
  #        experimental-features = nix-command flakes
  #        '';
#

  environment = {
    systemPackages = with pkgs; [
      batmon
      at
      rsync
      git
      git-crypt
      nix-prefetch-git
      nix-prefetch-github
      nix-index
      croc
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      file    # Program that shows the type of files
      unzip
      p7zip
      htop
      wget
      lsb-release
      screen
      procps
      tree
      neofetch
      #unstable.duf
      ncdu
      ripgrep
      vgrep
      tldr  # todo: maybe replace by tealdeer https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=tldr
      cheat

    ];

  };


}
