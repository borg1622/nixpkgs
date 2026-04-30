{ config, lib, pkgs, ... }:

{

  imports =
  [
  ];

  # Enable touchpad support (enabled default in most desktopManager).
    services = 
    {
      libinput = 
      {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          disableWhileTyping = true;
          accelSpeed = "0.8";
        };
      };
   };

  environment.systemPackages = with pkgs; [

  ];

}
