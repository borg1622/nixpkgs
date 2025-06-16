{ config, pkgs, ... }:

{
  networking = {
    timeServers = [
      "ntp0.voip.telefonica.de"
      "ntp1.voip.telefonica.de"
      "de.pool.ntp.org"
    ];
  };
}
