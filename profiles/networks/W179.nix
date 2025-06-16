{ config, pkgs, ... }:

{
  networking = {
    timeServers = [
      "ntp1.t-online.de"
      "de.pool.ntp.org"
    ];
  };
}
