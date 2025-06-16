

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "0.6.10";
  drv = stdenv.mkDerivation {
    pname = "keetheme";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/xatupal/KeeTheme/releases/download/v${version}/KeeTheme.plgx";
      sha256 = "1dm6424xs2f9djp68ij0gk5f4bavvz6ax3rpyapfkxw130z5vihq";
    };

    meta = with stdenv.lib; {
      description = "Plugin changes the appearance of KeePass, to make it look better at night.";
      homepage    = "https://github.com/xatupal/KeeTheme";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeeTheme.plgx";

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
