

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "0.9.1";
  drv = stdenv.mkDerivation {
    pname = "coloredpassword";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/Rookiestyle/ColoredPassword/releases/download/v${version}/ColoredPassword.plgx";
      sha256 = "1nzxbjndpxj6pyx1svdzswwgisif1ckl8a2cy2svyjyry8irw5mc";
    };

    meta = with stdenv.lib; {
      description = "Use different colors for digits and special chars in passwords ";
      homepage    = "https://github.com/Rookiestyle/ColoredPassword";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "ColoredPassword.plgx";

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
