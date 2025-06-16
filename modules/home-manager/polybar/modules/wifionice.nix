{
  services.polybar.config."module/wifionice" = {
    type              = "custom/script";
    
    # todo replace by path by nix variable
    "exec"            = ''~/.config/polybar/scripts/info-wifionice.sh --background "#C4C7C5" --foreground "#1C1E20"''; 
    # click-left = "kill -USR1 $(pgrep --oldest --parent %pid%)"
    interval          = 10;
    # ;tail = true
    format            = "<label>";
    format-background = "\${color.mf}";
    format-foreground = "\${color.fg}";
    # ;format-padding = 2
  }; 
}