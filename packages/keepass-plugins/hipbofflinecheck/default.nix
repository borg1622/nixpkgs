

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.7.3";
  drv = stdenv.mkDerivation {
    pname = "hipbofflinecheck";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/mihaifm/HIBPOfflineCheck/releases/download/${version}/HIBPOfflineCheck.plgx";
      sha256 = "0nwa2xgh4zcgx9anf3gyflhl6kqj62234v269rbaa5fzkh1c4fnp";
    };

    meta = with stdenv.lib; {
      description = "Plugin that performs offline and online checks against HaveIBeenPwned passwords ";
      homepage    = "https://github.com/mihaifm/HIBPOfflineCheck";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "HIBPOfflineCheck.plgx";

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
