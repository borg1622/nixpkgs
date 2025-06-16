{ config, pkgs, input, ... }:



{

  imports =
  [
    ./system-generic.nix
    ../services/i3.nix
    ../services/fonts/desktop.nix
  ];


  nixpkgs.overlays = [
    (self: super: {
     #keepass-keepassrpc = super.keepass-keepassrpc.overrideAttrs (oldAttrs: {
    #    name = "keepassrpc-1.8.0";
    #    src = super.fetchurl {
    #      url    = "https://github.com/kee-org/keepassrpc/releases/download/v1.8.0/KeePassRPC.plgx";
    #      sha256 = "8d9d5e390fc4a3b8d6d8f24dd26a712dc032c4ff49708c8ec32c95a2e27594b5";
    #    };
    #  });
      keepass = super.keepass.override {
          plugins = [ self.keepass-keepasshttp
                      #self.keepass-keeagent
                      #self.keepass-keepassrpc
                      #self.keepass-otpkeyprov
                      (import ../packages/keepass-plugins/test) ];
      };
    })
  ];

  environment.sessionVariables.TERMINAL = [ "terminator" ]; # todo: make sure terminator is installed !

  environment.systemPackages = with pkgs; [
      gnome3.nautilus
      gnome3.sushi
      #baobab
      mono # used to build keepass plugin
      keepass
      pamtester
      bc
  ];

  security.pam.u2f = {
    enable = true;
    settings.debug = true;
    settings.cue = true;
    control = "sufficient";
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
     };
  };

}
