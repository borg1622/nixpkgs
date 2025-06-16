{
  services.polybar.config."module/battery" = {
    type                          = "internal/battery";
    full-at                       = 99;

    battery                       = "BAT0";
    adapter                       = "AC";

    poll-interval                 = 60;
    time-format                   = "%H:%M";

    format-charging               = "<label-charging>";
    format-charging-background    = "\${color.mf}";
    format-charging-foreground    = "\${color.fg}";
    format-charging-padding       = 1;

    format-discharging            = "<label-discharging>";
    format-discharging-background = "\${color.mf}";
    format-discharging-foreground = "\${color.fg}";
    format-discharging-padding    = 2;

    label-charging                = "%percentage%%";
    label-discharging             = "%percentage%%";

    label-full                    = "100%";
    label-full-foreground         = "\${color.fg}";
    label-full-background         = "\${color.mf}";
    label-full-padding            = 2;
  };

  services.polybar.settings."module/battery_i" = {
    type                          = "internal/battery";
    full.at                       = 99;

    battery                       = "BAT0";
    adapter                       = "AC";

    poll.interval                 = 60;
    time.format                   = "%H:%M";

    format.charging.text          = "<animation-charging>";
    format.charging.background    = "\${color.green}";
    format.charging.foreground    = "\${color.fg}";
    format.charging.padding       = 1;

    format.discharging.text       = "<ramp-capacity>";
    format.discharging.background = "\${color.pink}";
    format.discharging.foreground = "\${color.fg}";
    format.discharging.padding    = 2;

    label.charging                = "%percentage%%";
    label.discharging             = "%percentage%%";

    label.full.text               = "";
    label.full.foreground         = "\${color.green}";
    label.full.background         = "\${color.fg}";
    label.full.padding            = 2;

    ramp.capacity                 = [ "" "" "" "" "" "" "" "" "" ];
    animation.charging.text       = [ "" "" "" "" "" "" "" "" "" ];

    animation.charging.framerate  = 1000;

  };

}

