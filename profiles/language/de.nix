{ config, pkgs, ... }:

{
  # todo: add conditional expression to apply option when needed
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e";

  i18n.defaultLocale = "de_DE.UTF-8";

  console.keyMap = "de";

}
