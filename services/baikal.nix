{ pkgs, lib, config, ... }:
let
  app = "baikal";
  inherit (import ../secrets/ssl-cert.nix) sslCert sslCertKey sslTrustedCert;
  inherit (import ../secrets/domain1-sensitive.nix) baikal-domainName;

  dataDir = "/var/www/${baikal-domainName}/html";
in {

  services.phpfpm.pools.${app} = {
    user = app;
    settings = {
      "listen.owner" = config.services.nginx.user;
      "listen.group" = config.services.nginx.group;
      "listen.mode" = "0660";
      "pm" = "dynamic";
      "pm.max_children" = 75;
      "pm.start_servers" = 10;
      "pm.min_spare_servers" = 5;
      "pm.max_spare_servers" = 20;
      "pm.max_requests" = 500;
      "catch_workers_output" = 1;
    };
  };

  users.groups.${app} = {
    members = [ "${app}"];
  };
  users.users.${app} = {
    isSystemUser = true;
    group = "${app}";
  };
  
  users.users.nginx.extraGroups = [ "acme" "${app}"];

  services.nginx = {
    enable = true;
    #logError = "stderr debug";

    virtualHosts = {
      ${baikal-domainName} = {
        sslCertificate = sslCert;
        sslTrustedCertificate = sslTrustedCert;
        sslCertificateKey = sslCertKey;
        forceSSL = true;

        root = "${dataDir}";

        extraConfig = ''
          	port_in_redirect off;
            dav_methods off;
            charset utf-8;
            index index.php;

            rewrite ^/.well-known/caldav /dav.php redirect;
            rewrite ^/.well-known/carddav /dav.php redirect;
        '';

        locations."~ /(\\.ht|Core|Specific|config)" = {
          extraConfig = ''
            deny all;
            return 404;
          '';
        };

        locations."~ ^(.+\\.php)(.*)$"  = {
          extraConfig = ''
            # Check that the PHP script exists before passing it
            try_files $fastcgi_script_name =404;
            include ${config.services.nginx.package}/conf/fastcgi_params;
            fastcgi_split_path_info  ^(.+\.php)(.*)$;
            fastcgi_pass unix:${config.services.phpfpm.pools.${app}.socket};
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO        $fastcgi_path_info;

            include ${pkgs.nginx}/conf/fastcgi.conf;            
          '';
        };
      };
    };
  };
}
