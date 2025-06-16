{ config, pkgs, ... }:

{
  networking = {
    timeServers = [
      "de.pool.ntp.org"
    ];
  };
}
