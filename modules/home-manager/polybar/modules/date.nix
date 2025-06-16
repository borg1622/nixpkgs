

{
  services.polybar.config."module/date" = {
    type              = "internal/date";
    interval          = "5.0";
    time              = "%H:%M  ||  %d.%m.%Y";
    time-alt          = "%H:%M";
    format            = "<label>";
    format-background = "\${color.mf}";
    format-foreground = "\${color.fg}";
    format-padding    = 2;
    label             = "%time%";
  };

  services.polybar.config."module/date_i" = {
    type              = "internal/date"; 
    interval          = "5.0";
    time              = "";
    time-alt          = "";
    format            = "<label>";
    format-background = "\${color.amber}";
    format-foreground = "\${color.fg}";
    format-padding    = 2;
    label             = "%time%";
  };

  services.polybar.config."module/date2" = {
    type              = "internal/date"; 
    interval          = "60.0";
    date              = "%d.%m.%Y";
    time              = "%H:%M";
    label             = "%{A1:gnome-calculator:} %date% %{A}  %time%";
    label-font        = 1;
    label-active-font = 1;
  };
}

