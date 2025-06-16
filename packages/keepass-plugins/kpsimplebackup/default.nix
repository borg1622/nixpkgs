
# !!! todo: unzip !!!
{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.3.0";
  drv = stdenv.mkDerivation {
    pname = "kpsimplebackup";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/marvinweber/KPSimpleBackup/releases/download/v1.3.0/KPSimpleBackup-v${version}.zip";
      sha256 = "1is0hh29i25c58h84aa86hwnz7sm5326bdv1p53r7ab461dbl167";
    };

    meta = with stdenv.lib; {
      description = "KPSimpleBackup - Backup Plugin for KeePass2 (compatible with IOProtocolExt).";
      homepage    = "https://github.com/marvinweber/KPSimpleBackup";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    # !!! todo: rename !!!
    pluginFilename = "KPSimpleBackup.plgx";

    # !!! todo: unzip !!!
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
