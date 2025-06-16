{
  services.polybar.config."bar/base" = {
    monitor             = "\${env:MONITOR:}";
    # monitor-strict = false;
    # override-redirect = false;
    fixed-center        = true;
    width               = "100%";
    height              = 22;
    offset-x            = 0;
    offset-y            = 0;
    background          = "\${color.bg}";
    foreground          = "\${color.fg}";
    radius-top          = "0.0";
    radius-bottom       = "0.0";
    overline-size       = 2;
    overline-color      = "\${color.ac}";
    border-size         = 4;
    border-color        = "\${color.bg}";
    padding             = 1;
    module-margin-left  = 0;
    module-margin-right = 0;

    ## todo: require / install thesefonts in this nix file - not elsewhere
    font-0              = ''"Ubuntu Condensed:size=10;2"'';
    font-1              = ''"icomoon\-feather:size=10;2"''; 
    font-2              = ''"Inconsolata:size=12;2"'';
    font-3              = ''"FontAwesome:size=10;2"'';
    # font-0              = "Digital\\-7:size=12;3";
    font-4              = ''"7\-Segment:size=12;3"'';
    # https://torinak.com/7segment
    font-5              = ''"D\-DIN Condensed:size=12;2"'';
    font-6              = ''"Open Sans Condensed:size=9;4"'';
    font-7              = ''"Material Design Icons:size=10;2"'';
    # ;separator =
    dim-value           = "1.0";
    # ;wm.name =
    locale              = "de_DE.UTF-8";
    tray-position       = "none";
    tray-detached       = false;
    tray-maxsize        = 40;
    tray-background     = "\${color.bg}";
    tray-offset-x       = 0;
    tray-offset-y       = 0;
    tray-padding        = 0;
    tray-scale          = "1.0";
    enable-ipc          = true;
  };
  services.polybar.config."bar/top" = {
    "inherit"           = "bar/base";
    modules-left        = "filesystem_i filesystem separator";
    modules-right       = "backlight_i backlight separator pulseaudio_i pulseaudio separator battery_i battery  separator date_i date";
  };
  services.polybar.config."bar/bottom" = {
    "inherit"           = "bar/base";
    bottom              = true;
    tray-position       = "right";
    modules-left        = "i3";
    modules-right       = "wired-network separator vpn separator wireless-network separator bluetooth separator";
    dpi                 = 192;
    height              = 38;
  };
  services.polybar.config."bar/top-ext" = {
    "inherit"           = "bar/base";
    modules-left        = "filesystem_i filesystem separator";
    modules-center      = "date2";
    modules-right       = "pulseaudio_i pulseaudio separator battery_i battery separator date_i date";
    dpi                 = 192;
    height              = 38;
  };
  services.polybar.config."bar/top-uhd" = {
    "inherit"           = "bar/base";
    # ;modules-left =  filesystem_i filesystem separator
    modules-right       = "separator battery_i battery separator date_i date";
    dpi                 = 192;
    height              = 38;
  };
  services.polybar.config."bar/bottom-uhd" = {
    "inherit"           = "bar/base";
    bottom              = true;
    tray-position       = "right";
    modules-left        = "i3";
    modules-right       = "wired-network separator vpn separator wireless-network separator bluetooth separator";
    dpi                 = 192;
    height              = 38;
  };

}