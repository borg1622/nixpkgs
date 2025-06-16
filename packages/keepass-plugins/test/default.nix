with import <nixpkgs> {}; # bring all of Nixpkgs into scope
let
  version = "1.2.4.0";
in
stdenv.mkDerivation rec {
  name = "KeePass-Yet-Another-Favicon-Downloader";
  src = fetchurl {
    url    = "https://github.com/navossoc/KeePass-Yet-Another-Favicon-Downloader/releases/download/v${version}/YetAnotherFaviconDownloader.plgx";
    sha256 = "54cb6783d29e63234802e024402cae448873d99429810f7206fa7c98bad88572";
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
}
