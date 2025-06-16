{
  services.polybar.config."module/pulseaudio" = {
    type                      = "internal/pulseaudio";
    # pacmd list-sinks | grep -e 'name:' -e 'index:'
    # sink                      = "alsa_output.pci-0000_12_00.3.analog-stereo";
    sink                      = "alsa_output.pci-0000_06_00.6.HiFi__hw_Generic_1__sink";
    use-ui-max                = true;
    interval                  = 5;
    format-volume             = "<label-volume>";
    format-volume-background  = "\${color.mf};";
    format-volume-foreground  = "\${color.fg}";
    format-volume-padding     = 2;
    label-muted               = ".";
    format-muted-background   = "\${color.mf}";
    format-muted-foreground   = "\${color.red}";
    format-muted-padding      = 0;
    click-right               = "pavucontrol";
  };

  services.polybar.config."module/pulseaudio_i" = {
    type                      = "internal/alsa"; # todo: check homepage if this is correct
    format-volume             = "<ramp-volume>";
    format-volume-background  = "\${color.blue}";
    format-volume-foreground  = "\${color.fg}";
    format-volume-padding     = 2;
    format-muted-background   = "\${color.blue}";
    format-muted-foreground   = "\${color.red}";
    format-muted-padding      = 2;
    label-muted               = "";
    label-muted-foreground    = "\${color.fg}";
    ramp-volume-0             = "";
    ramp-volume-1             = "";
    ramp-volume-2             = "";
    ramp-volume-3             = "";
    ramp-volume-4             = "";
    ramp-headphones-0         = "";
    ramp-headphones-1         = "";
    click-right               = "pavucontrol";
  };
}

