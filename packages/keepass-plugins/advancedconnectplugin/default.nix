

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.0.5";
  drv = stdenv.mkDerivation {
    pname = "advancedconnectplugin";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/aalbng/AdvancedConnectPlugin/releases/download/${version}/AdvancedConnectPlugin.plgx";
      sha256 = "0zbkzziqnfv7khhzgfgdd3p3222qgkhjvy6h35ixd5g76p0sn3jw";
    };

    meta = with stdenv.lib; {
      description = "AdvancedConnect gives you the possibility to provide different applications for direct connections.";
      homepage    = "https://github.com/aalbng/AdvancedConnectPlugin";
      license     = licenses.asl20;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "AdvancedConnectPlugin.plgx";

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
