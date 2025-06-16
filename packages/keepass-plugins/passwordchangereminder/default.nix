

{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.1.0";
  drv = stdenv.mkDerivation {
    pname = "passwordchangereminder";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/tiuub/PasswordChangeReminder/releases/download/v${version}/PasswordChangeReminder.plgx";
      sha256 = "0zd2cdanhb2phk0w816kd7p9486d74slqdwxhvlymxg9n10dq0xm";
    };

    meta = with stdenv.lib; {
      description = "A KeePass Plugin, which reminds you to change chosen passwords repetitive after a specific time span.";
      homepage    = "https://github.com/tiuub/PasswordChangeReminder";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "PasswordChangeReminder.plgx";

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
