{
  services.polybar.config."module/backlight" = {
    type              = "internal/backlight";
    card              = "acpi_video0";
    format            = "<label>";
    format-background = "\${color.mf}";
    format-foreground = "\${color.fg}";
    format-padding    = 2;
    label             = "%percentage%%";
  };

  services.polybar.config."module/backlight_i" = {
    type              = "internal/backlight"; 
    card              = "acpi_video0";
    format            = "<ramp>";
    format-background = "\${color.lime}";
    format-foreground = "\${color.fg}";
    format-padding    = 2;
    ramp-0            = "";
    ramp-1            = "";
    ramp-2            = "";
    ramp-3            = "";
    ramp-4            = "";
  };
}
