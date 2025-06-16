

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.2.0";
  drv = stdenv.mkDerivation {
    pname = "keepass-customicondashboarder";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/incognito1234/KeePass-Custom-Icon-Dashboarder/releases/download/v${version}/CustomIconDashboarder.plgx";
      sha256 = "0cmdhl6zdcxnsvjfazkb24k1jn5qycq1bpcgvn1kz4z90nh47iww";
    };

    meta = with stdenv.lib; {
      description = "KeePass Plugin to download and manage custom icons";
      homepage    = "https://github.com/incognito1234/KeePass-Custom-Icon-Dashboarder";
      license     = licenses.gpl2Only; # some parts are licensed unter MIT
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "CustomIconDashboarder.plgx";

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
