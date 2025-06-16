
let
  domain = "0hq.de";
in {
  base-domain = "${domain}";
  baikal-domainName = "baikal-dmo.${domain}";
  nc-domainName = "nixcloud-dmo.${domain}";
  matrix-domainName = "mtrx-all.${domain}";
  acme-email = "acme@dirk-osburg.de";
  inwx-creds = ''fi6QyyJtdcukXSkv9jqMj8iqe4n7'';
  synapse-password = ''WTV1lrsvuoBcAmCh3JM83NQzS'';
}