{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;
  };
in
{

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true; # to be removed
      PermitRootLogin = lib.mkOverride 999 "no";
      LogLevel = "DEBUG3";
      # KexAlgorithms = [
      #     "sntrup761x25519-sha512@openssh.com"
      #     "curve25519-sha256"
      #     "curve25519-sha256@libssh.org"
      #     "diffie-hellman-group-exchange-sha256"
      #     ""

      # ];
      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
        "hmac-sha2-256"  # needed for Brother compatibility
      ];
    };

    sftpServerExecutable = "internal-sftp";
    # HostKeyAlgorithms = ssh-rsa needed for Brother compatibility
    extraConfig = ''
      HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa
      PubkeyAcceptedAlgorithms +ssh-rsa
    '';
  };

  environment.systemPackages = with pkgs; [
    #unstable.pam_rssh
  ];

}
