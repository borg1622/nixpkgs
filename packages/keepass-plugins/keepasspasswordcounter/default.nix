

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "0.1";
  drv = stdenv.mkDerivation {
    pname = "keepasspasswordcounter";
    inherit version;
    src = fetchurl {
      url    = "https://sourceforge.net/projects/keepasspasswordcounter/files/v${version}/KPPasswordCounter.plgx/download";
      sha256 = "1z03h68hy714lw4b6b045i9wyv09hqgx5si58s8c9w3lb9hahx19";
    };

    meta = with stdenv.lib; {
      description = "KeePass Plugin to count and show entries sharing a password .";
      homepage    = "https://sourceforge.net/projects/keepasspasswordcounter/";
      license     = licenses.gpl2Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KPPasswordCounter.plgx";

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
