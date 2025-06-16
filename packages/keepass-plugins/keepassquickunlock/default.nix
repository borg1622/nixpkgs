

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "2.4";
  drv = stdenv.mkDerivation {
    pname = "keepassquickunlock";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/JanisEst/KeePassQuickUnlock/releases/download/v${version}/KeePassQuickUnlock.plgx";
      sha256 = "0l6d7688pjcrza33d3gy128gqn0zvcwmq3hpix29kvqdycik7bzy";
    };

    meta = with stdenv.lib; {
      description = "KeePass 2.x plugin which lets you unlock databases quickly.";
      homepage    = "https://github.com/JanisEst/KeePassQuickUnlock";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassQuickUnlock.plgx";

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
