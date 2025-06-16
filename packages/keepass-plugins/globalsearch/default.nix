

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "0.6.1";
  drv = stdenv.mkDerivation {
    pname = "globalsearch";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Rookiestyle/GlobalSearch/releases/download/v${version}/GlobalSearch.plgx";
      sha256 = "0a2a82v7p5ab6c2mbr8vp6rz16fh1441f49kqmdz8yc0rzr2h89m";
    };

    meta = with stdenv.lib; {
      description = "Enhance KeePass search functionality to search in all open databases";
      homepage    = "https://github.com/Rookiestyle/GlobalSearch";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "GlobalSearch.plgx";

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
