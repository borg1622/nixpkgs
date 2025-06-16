

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "0.99";
  drv = stdenv.mkDerivation {
    pname = "keepassmasterslavesync";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Angelelz/KeePassMasterSlaveSync/releases/download/v${version}/KeePassMasterSlaveSync.plgx";
      sha256 = "013q42ljiaj49zwwcvncsbjiwcv6bmdla4y8m58ga18yc0phcyiq";
    };

    meta = with stdenv.lib; {
      description = "A plugin that allows synchronization of specific groups or tags between local databases.";
      homepage    = "https://github.com/Angelelz/KeePassMasterSlaveSync";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassMasterSlaveSync.plgx";

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
