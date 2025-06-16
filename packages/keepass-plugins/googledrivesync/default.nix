

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "4.0.3-beta";
  drv = stdenv.mkDerivation {
    pname = "googledrivesync";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/walterpg/google-drive-sync/releases/download/v${version}/KeePassSyncForDrive-${version}.plgx";
      sha256 = "0lcd8l5g66pq4al7yn8ximiynhvxwhw94pns3xn59k2vhm4yqass";
    };

    meta = with stdenv.lib; {
      description = "A KeePass Password Safe v2 plugin for synchronizing passwords to Google Drive files.";
      homepage    = "https://github.com/walterpg/google-drive-sync";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassSyncForDrive.plgx";

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
