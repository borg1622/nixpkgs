

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.1";
  drv = stdenv.mkDerivation {
    pname = "keepassnewkeyexport";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/JanisEst/KeePassNewKeyExport/releases/download/v${version}/KeePassNewKeyExport.plgx";
      sha256 = "0npjfrrl323g0gjqhf4i0iakdp37cw734ccrk0a97aww8vl1s52h";
    };

    meta = with stdenv.lib; {
      description = "KeePassNewKeyExport is a plug-in for KeePass 2.x plugin which lets you export entries encrypted with a new password.";
      homepage    = "https://github.com/JanisEst/KeePassNewKeyExport";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassNewKeyExport.plgx";

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
