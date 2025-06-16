

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.0.0";
  drv = stdenv.mkDerivation {
    pname = "cardfilekpplugin";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/antboy/CardFileKPPlugin/releases/download/v${version}/CardFileKPPlugin.plgx";
      sha256 = "0vbfyh40igiv9nas52xikgs8hnrbh85lk4hfr9wv8y8dpc19yg71";
    };

    meta = with stdenv.lib; {
      description = "A plugin for Keepass. It enables importing a Microsoft Cardfile.";
      homepage    = "https://github.com/antboy/CardFileKPPlugin";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "CardFileKPPlugin.plgx";

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
