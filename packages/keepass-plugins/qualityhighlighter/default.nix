
{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.3.0.1";
  drv = stdenv.mkDerivation {
    pname = "qualityhighlighter";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/sdrichter/QualityHighlighter/releases/download/v${version}/QualityHighlighter.plgx";
      sha256 = "16nxdqhfr2xj9r1xhggnbd420lv2fqqqg85pq0ksm8vlcsf26dds";
    };

    meta = with stdenv.lib; {
      description = "A plugin for KeePass that highlights entries based on their password quality.";
      homepage    = "https://github.com/sdrichter/QualityHighlighter";
      license     = licenses.gpl2Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "QualityHighlighter.plgx";

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
