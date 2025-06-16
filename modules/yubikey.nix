{ lib, config, pkgs, inputs, pkgs-unstable, ... }:


with lib;

let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };
<<<<<<< HEAD
  unstable-packages = with pkgs-unstable; [
    yubico-piv-tool
    yubikey-manager-qt
    yubikey-personalization-gui
    yubikey-personalization
    libykclient
    yubico-pam
  ];
=======


>>>>>>> flake-conversion
in
{

  imports =
  [

  ];
  #security.pam.yubico.enable = true;

  services.yubikey-agent.enable = true;
<<<<<<< HEAD
  services.udev.packages = [ pkgs-unstable.yubikey-personalization ];

  environment.systemPackages = with pkgs; [
=======
  # services.udev.packages = [ unstable.yubikey-personalization ];
  services.udev.packages = [ pkgs.yubikey-personalization ];

  


  environment.systemPackages = with pkgs; [
    # unstable.yubico-piv-tool
    # unstable.yubikey-manager-qt
    # unstable.yubikey-personalization-gui
    # unstable.yubikey-personalization
    # unstable.libykclient
    # unstable.yubico-pam
    yubico-piv-tool
    yubikey-manager-qt   # to be replaced by yubioath-flutter
    yubioath-flutter
    yubikey-personalization-gui
    yubikey-personalization
    libykclient
    yubico-pam
>>>>>>> flake-conversion
    pamtester
    pam_u2f
  ] ++ unstable-packages;

  services.fprintd.enable = true;
  services.gnome.gnome-keyring.enable = true;

  security.pam = {
    u2f = {
      enable = true;
      
      
      control = "sufficient";

      settings = {
        debug = true;
        cue = true;
      };
    };

    services = {
      login = {
        u2fAuth = true;
        fprintAuth = lib.mkForce true;
        logFailures = true;
      };
      sudo = {
        u2fAuth = true;
        fprintAuth = lib.mkForce true;
        logFailures = true;
        # text = ''
          
        # '';
      };
      gnome-keyring = {
        u2fAuth = true;
        logFailures = true;
      };
     };
  };



}
