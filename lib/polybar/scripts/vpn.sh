#!/usr/bin/env bash

vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | head -1)"

background=${background:-"#FFF"}
foreground=${foreground:-"#000"}

if [ -n "$vpn" ]; then
  #vpn_if="$(echo "${vpn}" | cut -d ':' -f 3)"
  vpn_name="$(echo "${vpn}" | cut -d ':' -f 1)"
  #vpn_bitrate="$(ethtool ${vpn_if} 2>/dev/null | grep -oP 'Speed:\s\K\d+[^\s]+')"
  echo "%{B#61C766}%{F#1C1E20}  %{T8}󰍁 %{T-}%{B#C4C7C5}%{F#1C1E20}  $vpn_name  " # @${vpn_bitrate} "
else
  echo "%{B#EC7875}%{F#1C1E20}  %{T8}󰍀 "
fi
