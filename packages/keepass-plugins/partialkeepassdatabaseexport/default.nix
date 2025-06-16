

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.1.1";
  drv = stdenv.mkDerivation {
    pname = "partialkeepassdatabaseexport";
    inherit version;

    # !!! caution keepass version is hardcoded in download url !!!
    src = fetchurl {
      url    = "https://github.com/heinrich-ulbricht/partial-keepass-database-export/releases/download/v${version}/PartialKeePassDatabaseExport-v${version}_v2.39.1.zip";
      sha256 = "06hv8d1qzh7n8v1xjqnw615k6jmaabpawy5vnpiwazlk7vj766in";
    };

    meta = with stdenv.lib; {
      description = "Export tagged entries to a new password database every time you save. ";
      homepage    = "https://github.com/heinrich-ulbricht/partial-keepass-database-export";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    # !!! caution keepass version is hardcoded in download url !!!
    pluginFilename = "PartialKeePassDatabaseExport-v${version}_v2.39.1.zip";

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
