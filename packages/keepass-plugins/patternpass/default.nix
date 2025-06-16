

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.0";
  drv = stdenv.mkDerivation {
    pname = "patternpass";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/zedseven/PatternPass/releases/download/v${version}/PatternPass.plgx";
      sha256 = "17b4nzaimmm06qlzcbpg2965gz55h68hmxyay9z2gcckjib5sq1w";
    };

    meta = with stdenv.lib; {
      description = "A KeePass plugin that allows storage and viewing of pattern-based passwords (like the Android lock-screen).";
      homepage    = "https://github.com/zedseven/PatternPass";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "PatternPass.plgx";

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
