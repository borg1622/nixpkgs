

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.10";
  drv = stdenv.mkDerivation {
    pname = "pedcalc";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Rookiestyle/PEDCalc/releases/download/v${version}/PEDCalc.plgx";
      sha256 = "06x99p7g8ika30ssnbbyka3078f8qxjnaq9824z7vsz4l6xrhcaw";
    };

    meta = with stdenv.lib; {
      description = "Calculates the password expiry date dynamically after changing the password.";
      homepage    = "https://github.com/Rookiestyle/PEDCalc";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "PEDCalc.plgx";

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
