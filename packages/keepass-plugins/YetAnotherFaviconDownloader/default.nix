{ stdenv, buildEnv, fetchurl, mono }:

let
  version = "1.2.4.0";
  drv = stdenv.mkDerivation {
    pname = "KeePass-Yet-Another-Favicon-Downloader";
    inherit version;
    src = fetchurl {
      url    = "https://github.com/navossoc/KeePass-Yet-Another-Favicon-Downloader/releases/download/v${version}/YetAnotherFaviconDownloader.plgx";
      sha256 = "54cb6783d29e63234802e024402cae448873d99429810f7206fa7c98bad88572";
    };

    meta = with stdenv.lib; {
      description = "Yet Another Favicon Downloader (YAFD for short) is a plugin for KeePass 2.x that allows you to quickly download favicons for your password entries.";
      homepage    = "https://github.com/navossoc/KeePass-Yet-Another-Favicon-Downloader";
      license     = licenses.mit;
      maintainers = with maintainers; [ itc-ger ];
    };

    pluginFilename = "YetAnotherFaviconDownloader.plgx";

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
