# https://discourse.nixos.org/t/adding-folders-and-scripts/5114/2
# https://unix.stackexchange.com/questions/322814/xf86monbrightnessup-xf86monbrightnessdown-special-keys-not-working?answertab=votes#tab-top

{ config, pkgs, ... }:

let
  p14s-backlight-inc = pkgs.writeShellScriptBin "backlight-increase" ''
    bl_device=/sys/class/backlight/amdgpu_bl0/brightness
    echo $(($(cat $bl_device)+10)) | tee $bl_device
  '';

  p14s-backlight-dec = pkgs.writeShellScriptBin "backlight-decrease" ''
    bl_device=/sys/class/backlight/amdgpu_bl0/brightness
    echo $(($(cat $bl_device)-10)) | tee $bl_device
  '';


in {
  
  environment.systemPackages = [ 
     pkgs.acpid
     p14s-backlight-inc 
     p14s-backlight-dec 
  ];
  #security.sudo.extraConfig = ''
  #  ALL ALL=NOPASSWD: ${p14s-backlight-inc}/bin/backlight-increase
  #  ALL ALL=NOPASSWD: ${p14s-backlight-dec}/bin/backlight-decrease
  #'';
  services.acpid.handlers = {
    "p14bl-inc" = {
      action =  "${p14s-backlight-inc}/bin/backlight-increase";
      event =  "video/brightnessup BRTUP 00000086 00000000";
     };
    "p14bl-dec" = {
      action = "${p14s-backlight-dec}/bin/backlight-decrease";
      event = "video/brightnessdown BRTDN 00000087 00000000";
     };  
  };  

}
