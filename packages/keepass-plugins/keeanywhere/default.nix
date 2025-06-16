

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.6.0";
  drv = stdenv.mkDerivation {
    pname = "keeanywhere";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Kyrodan/KeeAnywhere/releases/download/v${version}/KeeAnywhere-${version}.plgx";
      sha256 = "0m1c615zqq6ppbd3svrrvf59nv9176zsq653jay9p0dj0xxaidc4";
    };

    meta = with stdenv.lib; {
      description = "KeeAnywhere is a KeePass plugin that provides access to cloud storage providers (cloud drives). ";
      homepage    = "https://github.com/Kyrodan/KeeAnywhere";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeeAnywhere.plgx";

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
