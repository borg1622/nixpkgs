{ config, pkgs, ... }:
{

  imports =
  [
 
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    # extraRules = [{
    #   commands = [        
    #     {
    #       command = "${pkgs.systemd}/bin/reboot";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "${pkgs.systemd}/bin/poweroff";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "${pkgs.systemd}/bin/systemctl suspend";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "/nix/store/*/bin/switch-to-configuration";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "/run/current-system/sw/bin/nix-store";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "/run/current-system/sw/bin/nix-channel";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "/run/current-system/sw/bin/nix-collect-garbage";
    #       options = [ "NOPASSWD" ];
    #     }
    #     {
    #       command = "/run/current-system/sw/bin/nix-collect-garbage";
    #       options = [ "NOPASSWD" ];
    #     }
    #   ];
    #   groups = [ "wheel" ];
    # }];
  };

  environment.systemPackages = with pkgs; [

  ];

}
