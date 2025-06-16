#!/usr/bin/env bash

nm_info="$(nmcli -t -f name,type,device connection show --order name --active 2>/dev/null | grep wireless | head -1)"


background=${background:-"#FFF"}
foreground=${foreground:-"#000"}

if [ -n "${nm_info}" ]; then
  wifi_if="$(echo "${nm_info}" | cut -d ':' -f 3)"
  wifi_ip="$(ip addr show "${wifi_if}" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//')"
  wifi_name="$(echo ${nm_info} | cut -d ':' -f 1)"
  wifi_if_info="$(iwconfig ${wifi_if})"
  wifi_bitrate="$(echo ${wifi_if_info} | grep -oP 'Bit\sRate=\K\d+(\.\d+)?\s[^\s]+')"
  wifi_freq="$(echo ${wifi_if_info} | grep -oP 'Frequency:\K\d(\.\d+)?\s[^\s]+')"
  #echo "ON ${wifi_name}@${wifi_freq} (${wifi_bitrate}) |  ${wifi_ip}  "
  echo "%{B#61C766}%{F#1C1E20}  󰖩  %{T-}%{B#C4C7C5}%{F#1C1E20}  ${wifi_name}@${wifi_freq} (${wifi_bitrate}) |  ${wifi_ip} "
else
  echo "%{B#EC7875}%{F#1C1E20} 󰖪 "
fi
