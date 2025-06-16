

{
  services.polybar.config."module/filesystem" = {
    type                        = "internal/fs";
    mount-0                     = "/";
    interval                    = 90;
    fixed-values                = true;
    format-mounted              = "<label-mounted>";
    format-mounted-background   = "\${color.mf}";
    format-mounted-foreground   = "\${color.fg}";
    format-mounted-padding      = 2;
    format-unmounted            = "<label-unmounted>";
    format-unmounted-background = "\${color.mf}";
    format-unmounted-foreground = "\${color.fg}";
    format-unmounted-padding    = 2;
    label-mounted               = "%free%";
    label-unmounted             = "%mountpoint%: not mounted";
  };

  services.polybar.config."module/filesystem_i" = {
    type                        = "internal/fs";
    mount-0                     = "/";
    interval                    = 90;
    fixed-values                = true;
    format-mounted              = "";
    format-mounted-background   = "\${color.green}";
    format-mounted-foreground   = "\${color.fg}";
    format-mounted-padding      = 2;
    format-unmounted            = "";
    format-unmounted-background = "\${color.red}";
    format-unmounted-foreground = "\${color.fg}";
    format-unmounted-padding    = 2;
  };
}
