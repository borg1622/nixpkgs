

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.0";
  drv = stdenv.mkDerivation {
    pname = "keepasshipb";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/JanisEst/KeePassHIBP/releases/download/v${version}/KeePassHIBP.plgx";
      sha256 = "1n6nb4x8c8vlngb3ikszysynmx1v1h47gl1wyqdy8l89dab0k3rq";
    };

    meta = with stdenv.lib; {
      description = "KeePass 2.x plugin which checks passwords on https://haveibeenpwned.com/";
      homepage    = "https://github.com/JanisEst/KeePassHIBP/";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassHIBP.plgx";

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
