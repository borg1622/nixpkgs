
# !!! todo unzip !!!
{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.0.1";
  drv = stdenv.mkDerivation {
    pname = "wuerfelware";
    inherit version;
    src = fetchurl {
      # !!! hardcoded keepass version in url !!!
      url    = "https://github.com/heinrich-ulbricht/wuerfelware-passphrases-for-keepass/releases/download/v${version}/wuerfelware-v${version}_v2.39.1.zip";
      sha256 = "11l88afw47c8jzpfmixkhmgmw3gi25gdcpi9mdjp7yx91g8ci93w";
    };

    meta = with stdenv.lib; {
      description = "A KeePass password generator";
      homepage    = "https://github.com/heinrich-ulbricht/wuerfelware-passphrases-for-keepass";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    # !!! todo rename !!!
    pluginFilename = "wuerfelware.plgx";

    # !!! todo unzip !!!
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
