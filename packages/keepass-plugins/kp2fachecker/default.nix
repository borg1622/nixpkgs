

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.1.0";
  drv = stdenv.mkDerivation {
    pname = "kp2fachecker";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/tiuub/KP2faChecker/releases/download/v${version}/KP2faChecker.plgx";
      sha256 = "1wdah6f3rd9dpzx3p9hgcirvc5pmp5m7qkrc5ld4mg7gqiz7vpi4";
    };

    meta = with stdenv.lib; {
      description = "Checks your entries, whether or not they support 2FA.";
      homepage    = "https://github.com/tiuub/KP2faChecker";
      license     = licenses.asl20;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KP2faChecker.plgx";

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
