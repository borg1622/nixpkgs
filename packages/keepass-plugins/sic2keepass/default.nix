

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "2.0.1.0";
  drv = stdenv.mkDerivation {
    pname = "sic2keepass";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Alezy80/SIC2KeePass/releases/download/v${version}/SafeInCloudImp.plgx";
      sha256 = "1hsg11j76c3rfj886a4m0gwnfk6nwp6l053mzf4kaa19n1sl6z16";
    };

    meta = with stdenv.lib; {
      description = "This plugin allows to transfer SafeInCloud databases directly or via exported XML file into KeePass 2 password manager.";
      homepage    = "https://github.com/Alezy80/SIC2KeePass";
      license     = licenses.mit;  # SIC2KeePass contains sources from http://dotnetzip.codeplex.com/ library which has !!! Zlib License.!!!
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "SafeInCloudImp.plgx";

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
