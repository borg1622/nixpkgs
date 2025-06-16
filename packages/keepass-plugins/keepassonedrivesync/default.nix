KeePassOneDriveSync

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "2.1.2.1";
  drv = stdenv.mkDerivation {
    pname = "keepassonedrivesync";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/KoenZomers/KeePassOneDriveSync/releases/download/${version}/KeeOneDriveSync.plgx";
      sha256 = "186igm9ynwcpr63aylm87dkavmlw58piq6mm9fialsdz7ss8a1cz";
    };

    meta = with stdenv.lib; {
      description = "A free plugin for KeePass that allows syncing of multiple password databases from multiple OneDrives to a local version.";
      homepage    = "https://github.com/KoenZomers/KeePassOneDriveSync";
      license     = licenses.epl10;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeeOneDriveSync.plgx";

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
