{ lib, config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.diener = {
    isNormalUser = true;
    uid = 1404;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    # openssh.authorizedKeys.keyFiles = [ ../secrets/user.server.ssh.pub ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINTxS3nEzFxV00f97Yc/TEJBRaCVlie30fV0PpWDeMPc HE54-pi-ssh" ];
    
    shell = pkgs.zsh;
  };

  #users.users.dmo =
  #  { isNormalUser = true;
  #    description = "Dirks user account";
  #    extraGroups = [ "wheel" ];
  #    uid = 1001;
  #    openssh.authorizedKeys.keyFiles = [ ../secrets/VM-nixOS-dmo_ed25519.pub ];
  #    #openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOmBJ5zJBbLMe0c6JtTJ5p0Tr8Mrawr/5Si+2EZmpPXj dmo@dmo-X230" ];
  #  };
}
