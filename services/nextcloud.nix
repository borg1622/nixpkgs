{ config, pkgs, lib, ... }:

let
  inherit (import ../secrets/ssl-cert.nix) sslCert sslCertKey sslTrustedCert;
  inherit (import ../secrets/domain1-sensitive.nix) nc-domainName;
  inherit (import ../secrets/nextcloud-sensitive.nix) nc-adminuser nc-admininitpass;
in
{
  imports =
    [
      ../secrets/nextcloud-secrets.nix
    ];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;

    hostName = nc-domainName;
    home = "/var/www/${nc-domainName}";
    https = true;

    database.createLocally = true;
    config = {
      dbtype = "mysql";
      adminuser = nc-adminuser;
      adminpassFile = "${pkgs.writeText "adminpass" "${nc-admininitpass}"}";
      defaultPhoneRegion = "DE";
    };
    configureRedis = true;
    # caching.redis = true;
    caching.apcu = true;

    secretFile = "/etc/nextcloud/nextcloud-secrets.json";

    maxUploadSize = "2G";
    
    # some optimization values derived from: 
    # https://www.c-rieger.de/nextcloud-installationsanleitung/#c02
    phpOptions = {
      max_execution_time = "3600";
      max_input_time = "3600";
      "apc.enabled" = "1";
      "apc.shm_size" = "128M";
      "apc.enable_cli" = "1";
      "opcache.enable" = "1";
      "opcache.enable_cli" = "1";
      "opcache.memory_consumption" = "256";
      "opcache.interned_strings_buffer" = "128";
      "opcache.max_accelerated_files" = "130987";
      "opcache.revalidate_freq" = "5";
      "opcache.jit" = "1255";
      "opcache.jit_buffer_size" = "256M";
      "opcache.validate_timestamps" = "0";  # Any change to config.php will then require either restarting PHP, which is the case on NixOs rebuild
    };

    logLevel = 0;

    extraOptions = {
      "filelocking.enabled" = true;
      # todo: fix enabledPreviewProviders > backslash issues
      enabledPreviewProviders = [
        "OC\\Preview\\MP3"
        "OC\\Preview\\TXT"
        ''OC\Preview\MarkDown''
        ''OC\Preview\OpenDocument''
        ''OC\Preview\Krita''
        ''OC\Preview\Imaginary''
      ];
      preview_imaginary_url = "localhost:8088";
    };
  };

  # phpExtraExtensions = [

  # ];

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    # enableACME = true;

    sslCertificate = sslCert;
    sslTrustedCertificate = sslTrustedCert;
    sslCertificateKey = sslCertKey;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # enable imaginary - to speed up preview generation
  # https://github.com/h2non/imaginary#command-line-usage
  # todo: deactivated until fix of enabledPreviewProviders > backslash issues
  services.imaginary = {
    enable = true;
    settings.return-size = true;
    port = 8088;
  };

}


