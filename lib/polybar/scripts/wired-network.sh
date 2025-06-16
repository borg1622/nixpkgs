#!/usr/bin/env bash

nm_info="$(nmcli -t -f name,type,device connection show --order name --active 2>/dev/null | grep ethernet | head -1)"

background=${background:-"#FFF"}
foreground=${foreground:-"#000"}

if [ -n "${nm_info}" ]; then
  eth_if="$(echo "${nm_info}" | cut -d ':' -f 3)"
  eth_ip="$(ip addr show "${eth_if}" | grep -w "inet" | awk '{ print $2; }' | sed 's/\/.*$//')"
  eth_bitrate="$(ethtool ${eth_if} 2>/dev/null | grep -oP 'Speed:\s\K\d+[^\s]+')"

  echo "%{B#61C766}%{F#1C1E20}  %{T4}  %{T-}%{B#C4C7C5}%{F#1C1E20}  ${eth_ip} @${eth_bitrate}  "
else
  echo "%{B#EC7875}%{F#1C1E20}  %{T4}  "
fi
