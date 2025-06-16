{ config, pkgs, ... }:

{
  console.keyMap = "us";

  services.xserver.xkb = 
  {
    # Configure keymap in X11
    layout = "us";
    model = "pc104";
    options = "eurosign:e,compose:caps";
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
      "de_DE@euro/ISO-8859-15"
    ];
    extraLocaleSettings = {
      "LC_TIME" = "de_DE.UTF-8";
      "LC_NUMERIC" = "de_DE.UTF-8";
      "LC_MONETARY" = "de_DE.UTF-8";
      "LC_PAPER" = "de_DE.UTF-8";
    };

  };

}
