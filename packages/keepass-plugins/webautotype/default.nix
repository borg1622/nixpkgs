
# !!! todo: unzip package !!!
{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "6.4.0";
  drv = stdenv.mkDerivation {
    pname = "webautotype";
    inherit version;
    src = fetchurl {
      url    = "https://sourceforge.net/projects/webautotype/files/v6.4.0/WebAutoType-v${version}.zip/download";
      sha256 = "044hnn14aa4qfq6dnhfw879yy3i3yd0423r513nwqxrmwv27l6hv";
    };

    meta = with stdenv.lib; {
      description = "This is a plugin to KeePass to allow the AutoType functionality to work with browser URLs as well as window titles.";
      homepage    = "https://sourceforge.net/projects/webautotype/";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    # !!! todo: rename !!!
    pluginFilename = "webautotype.plgx";

    # !!! todo: unzip package !!!
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
