

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "0.5.0";
  drv = stdenv.mkDerivation {
    pname = "keepasssubsetexport";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/lukeIam/KeePassSubsetExport/releases/download/${version}/KeePassSubsetExport.plgx";
      sha256 = "1f4751wc68q5a3ahkahm7c4fa6sgqrbv0nlcr9y21zixmnlgwpiq";
    };

    meta = with stdenv.lib; {
      description = "KeePassSubsetExport is a KeePass2 plugin which automatically exports a subset of entries (tag based) to new databases with different keys.";
      homepage    = "https://github.com/lukeIam/KeePassSubsetExport";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassSubsetExport.plgx";

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
