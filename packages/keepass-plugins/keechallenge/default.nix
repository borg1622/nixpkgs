
# !!! todo: unzip !!!
{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.5";
  drv = stdenv.mkDerivation {
    pname = "keechallenge";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/brush701/keechallenge/releases/download/${version}/KeeChallenge_${version}.zip";
      sha256 = "0sgksfcn6mj7fmxwvsfzjr0dwhnxwry1rvc1p9lkmvlbhlviwsbs";
    };

    meta = with stdenv.lib; {
      description = "A plugin for KeePass2 to add Yubikey challenge-response capability.";
      homepage    = "https://github.com/brush701/keechallenge";
      license     = licenses.gpl3Only;
      maintainers = with maintainers; [ itc-ger ];
    };

    # !!! todo: rename !!!
    pluginFilename = "KeeChallenge.plgx";

    # !!! todo: unzip !!!
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
