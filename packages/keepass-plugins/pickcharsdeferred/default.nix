

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.2";
  drv = stdenv.mkDerivation {
    pname = "pickcharsdeferred";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/xatupal/PickCharsDeferred/releases/download/v${version}/PickCharsDeferred.plgx";
      sha256 = "10w1zrrnxpbcyn41kpz51pmdxq3883r56a4m41gs93lq35wlsk4l";
    };

    meta = with stdenv.lib; {
      description = "Plugin changes the default behaviour of '{PICKCHARS}' placeholder.";
      homepage    = "https://github.com/xatupal/PickCharsDeferred";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "PickCharsDeferred.plgx";

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
