

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "4.12.4";
  drv = stdenv.mkDerivation {
    pname = "keetoready";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/mridentity/KeeToReady/releases/download/v${version}/KeeToReady.plgx";
      sha256 = "14my3yhn0fklx65qmffwipk4fn26i2vwpjif6ba8yawrii2b3r8q";
    };

    meta = with stdenv.lib; {
      description = "KeePass plugin for importing and exporting ReadySignOn records.";
      homepage    = "https://github.com/mridentity/KeeToReady";
      license     = licenses.unfreeRedistributable;  # !!! license inf is missing !!!
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeeToReady.plgx";

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
