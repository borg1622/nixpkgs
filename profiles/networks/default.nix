{ config, pkgs, ... }:

{
  networking = {
    timeServers = [
      "0.de.pool.ntp.org"
      "1.de.pool.ntp.org"
      "2.de.pool.ntp.org"
      "3.de.pool.ntp.org"
    ];

    # domain = "lan";

    firewall = {
      enable = true;
      allowPing = false;
      pingLimit = "--limit 1/hour --limit-burst 5";
      checkReversePath = "strict";

    };
  };
}
