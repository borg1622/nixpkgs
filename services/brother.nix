# This file implements 
{ pkgs, lib, config, ... }:
let
  usrname = "brother";
  nextcloud-user = "nextcloud"; # todo replace by nextcloud config variable 
  nextcloud-groupfolder-id = "2";
  nextcloud-folder = "${config.services.nextcloud.home}/data/__groupfolders/${nextcloud-groupfolder-id}/";
in {
  imports =
    [
      ../users/user.brother.nix   # import secret parts of user configuration
    ];
  
  # create user for sftp access by the brother scanner, ssh-key is defined at external config file
  users.users.${usrname} = {
    isNormalUser = true;
    group = "${usrname}"; 
    createHome = true;
    homeMode = "770";
    shell = null;
  };

  # add nextcloud user to group so that nextcloud has access rights to added files
  users.groups.${usrname} = {
    members = [ "${usrname}" "${nextcloud-user}"]; # todo: replace static nextcloud string by config variable
  };  
  users.users.nextcloud.extraGroups = [ "${usrname}" ];

  # mount user home directory into nextcloud directory so that added files can be accessed by nextcloud
  fileSystems."/home/${usrname}" = {
    depends = [
      "/"
      "/home"
    ];
    device = nextcloud-folder;  
    fsType = "none";
    options = [
      "bind"
    ];
  };

  # Configuring SFTP access 
  #
  # todo hardening 
  # https://wiki.archlinux.org/title/SFTP_chroot
  # https://en.wikibooks.org/wiki/OpenSSH/Cookbook/File_Transfer_with_SFTP
  # ForceCommand internal-sftp -u 0666 -p realpath,open,write,close,lstat
  services.openssh.extraConfig = ''
    Match User ${usrname}
      ChrootDirectory /home/
      ForceCommand internal-sftp -d %u
      AllowTcpForwarding no
      PasswordAuthentication no
  '';

  # monitoring for newly added files and trigger nextcloud to refresh its file database
  systemd = {
    paths.nextcloud-brother-filewatch = {
      wantedBy = [ "multi-user.target" ];   # todo: revalidate which target is really necessary
      pathConfig.PathChanged = [ "${nextcloud-folder}" ];
    };

    services.nextcloud-brother-filewatch = {
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