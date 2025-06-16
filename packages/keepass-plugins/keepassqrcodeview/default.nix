
{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.0.4";
  drv = stdenv.mkDerivation {
    pname = "keepassqrcodeview";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/JanisEst/KeePassQRCodeView/releases/download/v${version}/KeePassQRCodeView.plgx";
      sha256 = "0vbfyh40igiv9nas52xikgs8hnrbh85lk4hfr9wv8y8dpc19yg71";
    };

    meta = with stdenv.lib; {
      description = "KeePassQRCodeView is a plug-in for KeePass 2.x which shows QR Codes for entry fields.";
      homepage    = "https://github.com/JanisEst/KeePassQRCodeView";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "KeePassQRCodeView.plgx";

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
