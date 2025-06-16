{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
  app = "nginx";
in
{
 
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  environment.systemPackages = with pkgs; [

  ];

}
