
{
  services.polybar.settings."module/i3" = {
    type                        = "internal/i3";
    pin.workspaces              = true;
    strip.wsnumbers             = true;
    index.sort                  = true;

    enable.click                = true;
    enable.scroll               = true;

    wrapping.scroll             = false;
    reverse.scroll              = false;

    format                      = "<label-state> <label-mode>";
    label.focused.text          = "%index% %icon%";
    label.focused.foreground    = "\${color.fg}";
    label.focused.background    = "\${color.lime}";
    label.focused.underline     = "\${color.lime}";
    label.focused.padding       = 3;

    label.unfocused.text        = "%index% %icon%";
    label.unfocused.foreground  = "\${color.fg}";
    label.unfocused.background  = "\${color.mf}";
    label.unfocused.underline   = "\${color.mf}";
    label.unfocused.padding     = 3;

    label.visible.text           = "%index% %icon%";
    label.visible.foreground    = "\${color.fg}";
    label.visible.background    = "\${color.grey}";
    label.visible.underline     = "\${color.mf}";
    label.visible.padding       = 3;

    label.mode.text             = "%mode%";
    label.mode.padding          = 2;
    label.mode.background       = "\${color.ac}";

    label.urgent.text           = "%index% %icon%";
    label.urgent.foreground     = "\${color.fg}";
    label.urgent.background     = "\${color.red}";
    label.urgent.padding        = 3;

    ws.icon = [ "1:www;" "2:vvv;" "3:Fui;" "4:Fcmd;" "5:vm-ctrl;"
                "6:vm-guest;" "7:mail;" "8:rmt;" "9:pwd;" "10:mon;"
                "11:cfg;" "12:kdb;" "13:dev;" "14:gfx;" ];
  };
}
