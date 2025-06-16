{
  # https://github.com/gvolpe/nix-config/blob/master/flake.nix
  # https://github.com/chrisportela/dotfiles/blob/main/flake.nix

  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager-unstable = {
    #   url = "github:nix-community/home-manager/master";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, ... }: {
    nixosConfigurations = {
      # TODO please change the hostname to your own
      p14s-dmo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        
        modules = [
          {
            nixpkgs.config = {
              allowUnfree = true;
              permittedInsecurePackages = [
                "yubikey-manager-qt-1.2.5"  
              ];
            };
          }

          nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen2

          # ./hardware/lenovo/p14s_gen2.nix
          ./machines/lenovo-p14s/default.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`

          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # ./users/user.desktop.nix {
            #   inherit home-manager;
            # };
            home-manager.users.dmo = ./users/user.desktop.nix;

            # TODO replace ryan with your own username
            # home-manager.users.dmo = import ./users/user.desktop.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };



  # outputs = { self, nixpkgs, ... }@inputs: {
  #   # Please replace my-nixos with your hostname
  #   nixosConfigurations.my-nixos = nixpkgs.lib.nixosSystem {
  #     system = "x86_64-linux";
  #     modules = [
  #       # Import the previous configuration.nix we used,
  #       # so the old configuration file still takes effect
  #       ./machines/lenovo-p14s/default.nix
  #     ];
  #   };
  # };
}