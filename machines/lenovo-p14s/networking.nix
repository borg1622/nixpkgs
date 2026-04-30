{ config, lib, pkgs, modulesPath, ... }:

{

  networking.hostId = "9b206745"; # head -c4 /dev/urandom | od -A none -t x4
  networking.hostName = "p14s-dmo"; # Define your hostname.

}