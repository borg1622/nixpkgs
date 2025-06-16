# This file implements 
{ pkgs, lib, config, ... }:
let
  usrname = "brother";
  nextcloud-user = "nextcloud"; # todo replace by nextcloud config variable 
  nextcloud-groupfolder-id = "2";
  nextcloud-folder = "${config.services.nextcloud.home}/data/__groupfolders/${nextcloud-groupfolder-id}/";
in {
  systemd = {
    # paths.nextcloud-brother-filewatch = {
    #   wantedBy = [ "multi-user.target" ];   # todo: revalidate which target is really necessary
    #   pathConfig.PathChanged = [ "${nextcloud-folder}" ];
    # };

    services.detect-docking = {
      wantedBy = [ "multi-user.target" ];   # todo: revalidate which target is really necessary
      after = [ "network.target" ];         # todo: revalidate which target is really necessary
      description = "Watch scanners user home dir for changes and trigger nextcloud rescan.";
      #path = [ "occ" ];  # todo>:to be removed. is this statement still necessary ?
      serviceConfig = {
        Type = "oneshot";
        User = "${nextcloud-user}";  
        ExecStart = "${config.services.nextcloud.occ}/bin/nextcloud-occ groupfolders:scan ${nextcloud-groupfolder-id}";         
      };  
    };
  };
}