

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.2.1";
  drv = stdenv.mkDerivation {
    pname = "readablepassphrasegenerator";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/ligos/readablepassphrasegenerator/releases/download/release-${version}/ReadablePassphrase.${version}.plgx";
      sha256 = "0nn3b8cfn6dslik8w7l168sb7d4vnra473ayfxw1rz8102p624nr";
    };

    meta = with stdenv.lib; {
      description = "The Readable Passphrase Generator generates passphrases which are (mostly) grammatically correct but nonsensical.";
      homepage    = "https://github.com/ligos/readablepassphrasegenerator";
      license     = licenses.asl20;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassQRCodeView.plgx";

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
