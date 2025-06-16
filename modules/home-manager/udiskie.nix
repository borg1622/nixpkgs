{config, home, ...}:
{
  # #### This file is intended to be included by a home-manager configugration
  # #### -> home-manager.users.*.imports = [ "<thisfile>" ];
  services.udiskie = {
      enable = true;
      tray = "always";
   };
}