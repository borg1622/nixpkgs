# This script implements a network manager hook script for 
# auto toggling of wifi depending on active wired ethernet connection
# if a wired ethernet connection is established then widi will be deactivated - and vice versa

{ pkgs, lib, config, ... }:
let
  
in {
  networking.networkmanager.dispatcherScripts = [ {
    source = pkgs.writeText "toggleWifi-upHook" ''
        NM_CMD="${pkgs.networkmanager}/bin/nmcli"
        IF_TYPE=$($NM_CMD -g GENERAL.TYPE device show $1)
        echo "# $1 $2 IF_TYPE: $IF_TYPE"

        if [ "$IF_TYPE" = "ethernet" ]; then
          case "$2" in
              up)
                  echo "switching WiFi Adapter off"
                  $NM_CMD radio wifi off
                  #echo "nmcli radio wifi off"
                  ;;
              down)
                  echo "switching WiFi Adapter on #1"
                  sleep 1
                  $NM_CMD -w 5 radio wifi on
                  sleep 5
                  $NM_CMD -w 5 radio wifi on
                  echo "$($NM_CMD radio wifi)"

                  ;;
          esac

      '';
    type = "basic";
  } ];
}