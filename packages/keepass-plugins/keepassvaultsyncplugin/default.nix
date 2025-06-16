

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.0.3";
  drv = stdenv.mkDerivation {
    pname = "keepassvaultsyncplugin";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Orange-OpenSource/keepass-vault-sync-plugin/releases/download/${version}/VaultSyncPlugin.plgx";
      sha256 = "1k6xxdl9ahmqidlk7bmzzwx80wppmpacgyg5alrnsbnf8g8cpx8b";
    };

    meta = with stdenv.lib; {
      description = "Keepass plugin to synchronize Hashicorp Vault secrets.";
      homepage    = "https://github.com/Orange-OpenSource/keepass-vault-sync-plugin";
      license     = licenses.lgpl21Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "VaultSyncPlugin.plgx";

    unpackCmd = ''
      mkdir deps/
      cp -p $src deps/$pluginFilename
    '';
    sourceRoot = "deps";

    installPhase = ''
      mkdir -p $out/lib/dotnet/keepass/
      cp $pluginFilename $out/lib/dotnet/keepass/$pluginFilename
    '';
  };
in
  # Mono is required to compile plugin at runtime, after loading.
  buildEnv { name = drv.name; paths = [ mono drv ]; }
