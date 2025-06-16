{config, ...}:
let
  scriptPath = "polybar/scripts/bluetooth.sh";
in {
  services.polybar.config."module/bluetooth" = {
    type          = "custom/script";
    exec          = "${config.xdg.dataHome}/${scriptPath}";
    #;click-left = "kill -USR1 $(pgrep --oldest --parent %pid%)" --background "#C4C7C5" --foreground "#1C1E20"
    interval      = 20;
  };

  xdg.dataFile.${scriptPath} = {
    executable    = true;
    text = ''
      #!/usr/bin/env bash

      bt_info="" # "$(hcitool dev | grep -E "hci[0-9]+" 2>/dev/null )"


      background=''${background:-"#FFF"}
      foreground=''${foreground:-"#000"}

      if [ -n "$bt_info" ]; then
        bt_conn="$(hcitool con | grep -oE '([0-9A-F]{2}:){5}[0-9A-F]{2}' | wc -l)"
        #wifi_ip="$(ip addr show "$wifi_if" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//')"
        #wifi_name="$(echo "$nm_info" | cut -d ':' -f 1)"
        if [ "$bt_conn" == "0" ]; then
          echo "%{B#EBD369}%{F#1C1E20}  %{T8}󰂯 "
        else
          echo "%{B#61C766}%{F#1C1E20}  %{T8}󰂰 %{T-}%{B#C4C7C5}%{F#1C1E20}   $bt_conn   "
        fi
      else
        echo "%{B#EC7875}%{F#1C1E20}  %{T8}󰂲 "
      fi
    '';
  };
}

