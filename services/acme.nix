{ config, pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
  inherit (import ../secrets/domain1-sensitive.nix) domain acme-email inwx-creds;

in
{
  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = acme-email;
  #   certs."${domain}" = {
  #     domain = "*.${domain}";
  #     dnsProvider = "desec";

  #     # Suplying password files like this will make your credentials world-readable
  #     # in the Nix store. This is for demonstration purpose only, do not use this in production.
  #     credentialsFile = "${pkgs.writeText "inwx-creds" ''
  #       DESEC_TOKEN=${inwx-creds}
  #       DESEC_TTL=300
  #     ''}";
  #   };
  # };



  environment = {
    systemPackages = with pkgs; [
      certbot
    ];

    etc = {
      "letsencrypt/cli.ini" = {
        text = ''
          # Because we are using logrotate for greater flexibility, disable the                                                                                                                                           
          # internal certbot logrotation.                                                                                                                                                                                 
          max-log-backups = 0                                                                                                                                                                                             
                                                                                                                                                                                                                           
          # Use a 4096 bit RSA key instead of 2048                                                                                                                                                                        
          rsa-key-size = 4096                                                                                                                                                                                                                                                                                                                                                                                                                        
          
          # basic config                                                                                                                                                                                                  
          agree-tos = true                                                                                                                                                                                                
          no-eff-email = true  
        '';
      };
    };
  };
  
}
