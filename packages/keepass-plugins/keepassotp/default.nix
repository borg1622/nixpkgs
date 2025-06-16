

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "0.18.2";
  drv = stdenv.mkDerivation {
    pname = "keepassotp";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Rookiestyle/KeePassOTP/releases/download/v${version}/KeePassOTP.plgx";
      sha256 = "1vf79nlaihlc6q5ff2yz7h5mqvnn7lpbwplg4c19dz32iyar9fjn";
    };

    meta = with stdenv.lib; {
      description = "Add OTP support (two factor authentication) to KeePass.";
      homepage    = "https://github.com/Rookiestyle/KeePassOTP";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassOTP.plgx";

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
