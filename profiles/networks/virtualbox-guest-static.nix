{ config, pkgs, ... }:

{
  imports =
  [
    ./default.nix
  ];

  networking = {
    interfaces.enp0s8.ipv4.addresses = [ {
      address = "192.168.56.99";
      prefixLength = 24;      
    } ];
  };
}
