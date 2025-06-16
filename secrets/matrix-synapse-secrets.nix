{ config, pkgs, lib, ... }:

{  # todo: replace -> avoid sercerts in nix store
  # https://matrix-org.github.io/synapse/latest/usage/configuration/config_documentation.html#registration_shared_secret_path
  environment.etc."matrix/synapse-secrets.json".text = ''
    registration_shared_secret: 'wItZA1XBkwMugMWnqh0qn1nSLxTmvvABIWrWHIMbU33TCaCmjkvP3yCoG59SwA1Y'
  '';

}








