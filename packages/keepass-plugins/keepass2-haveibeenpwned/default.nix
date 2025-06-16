

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.3.6";
  drv = stdenv.mkDerivation {
    pname = "keepass2-haveibeenpwned";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/andrew-schofield/keepass2-haveibeenpwned/releases/download/v${version}/HaveIBeenPwned.plgx";
      sha256 = "02kwrxd0qlvk24676kkh588qn1wp51l3vj8fwc6xjrdkgbnzqpg5";
    };

    meta = with stdenv.lib; {
      description = "Simple Have I Been Pwned checker for KeePass ";
      homepage    = "https://github.com/andrew-schofield/keepass2-haveibeenpwned";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "HaveIBeenPwned.plgx";

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
