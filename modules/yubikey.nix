{ lib, config, pkgs, inputs, ... }:


with lib;

let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };


in
{

  imports =
  [

  ];
  #security.pam.yubico.enable = true;

  services.yubikey-agent.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  environment.systemPackages = with pkgs; [
    yubico-piv-tool
    #yubikey-manager-qt   # to be replaced by yubioath-flutter
    yubioath-flutter
    #yubikey-personalization-gui
    yubikey-personalization
    libykclient
    yubico-pam
    pamtester
    pam_u2f
  ];

  # todo: refactor -> dedicated authentication module for desktop clients
  services.fprintd.enable = true;
  services.gnome.gnome-keyring.enable = true;
  # todo: u2f keyring unlock: https://221b.uk/gnome-login-using-u2f-security-tokens
  # maybe related to https://search.nixos.org/options?channel=25.05&show=security.pam.services.%3Cname%3E.enableGnomeKeyring&from=0&size=50&sort=relevance&type=packages&query=keyring

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
        unixAuth = true;
        u2fAuth = true;
        fprintAuth = lib.mkForce true;
        logFailures = true;
        enableGnomeKeyring = true;
      };
      i3lock = {
        enable = true;
        u2fAuth = true;
        fprintAuth = lib.mkForce true;
        logFailures = true;
      };
      xlock.enable = true;

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
