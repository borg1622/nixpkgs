{ config, pkgs, lib, ... }:

{  # todo: replace -> avoid sercerts in nix store
  environment.etc."nextcloud/nextcloud-secrets.json".text = ''
    {
      "passwordsalt": "mLRy1uiBMSUN8A0ti7Wd",
      "secret": "NaKVI733vLMog59tzTqViU4SW0KreF",
      "instanceid": "tCX0zk040g3mSNS"      
    }
  '';
      # "redis": {
      #   "password": "secret"
      # }
}








