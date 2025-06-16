# This file implements 
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
        # else
        #     ETH_AVAIL=0
        #     CONN_ACTIVE=$($NM_CMD -t con show --active | cut -d ':' -f4)
        #     echo "active connections: $CONN_ACTIVE"
        #     while IFS= read -r line; do
        #       NW_TYPE=$($NM_CMD -g GENERAL.TYPE device show $line)
        #       NW_STATE=$($NM_CMD -g GENERAL.STATE device show $line)
        #       if [ "$NW_TYPE" = "ethernet" ] \
        #          && [ "$NW_STATE" = "100 (connected)" ]; then
        #         ETH_AVAIL=1
        #         echo "active ethernet found: $line $NW_TYPE $NW_STATE"
        #         break
        #       fi
        #     done <<< $CONN_ACTIVE

        #     echo "Ethernet available status: $ETH_AVAIL"
        #     if [ "$ETH_AVAIL" = "0" ] ; then
        #       echo "switching WiFi Adapter on #2"
        #       $NM_CMD radio wifi on
        #     fi
        fi
      '';
    type = "basic";
  } ];
}