{ config, ... }:

{
  users.users.dmo =
    { isNormalUser = true;
      description = "Dirks user account";
      extraGroups = [ "wheel" "vboxsf" ];
      uid = 1001;
      openssh.authorizedKeys.keyFiles = [ ../secrets/VM-nixOS-dmo_ed25519.pub ];
      #openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOmBJ5zJBbLMe0c6JtTJ5p0Tr8Mrawr/5Si+2EZmpPXj dmo@dmo-X230" ];
    };
}
