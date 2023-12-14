{
  description = "Carson Moore's Nix Config for general home usage.";

  # Setup Cachix
  nixConfig = {
    substituters = [
      "https://cache.nixos.org/"
    ];

    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-colors
    nix-colors.url = "github:misterio77/nix-colors";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      # Your custom packages
      packages = forAllSystems (system: import ./custom/pkgs nixpkgs.legacyPackages.${system});
      
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./custom/overlays {inherit inputs;};
      
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./custom/modules/nixos;
      
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./custom/modules/home-manager;

      # Available through 'nixos-rebuild --flake .#hostname'
      nixosConfigurations = {
        # Personal Laptop
        angkor = nixpkgs.lib.nixosSystem {
          modules = [./hosts/angkor];
          specialArgs = { inherit inputs outputs; };
        };
        # Future Gaming Desktop
        skadi = nixpkgs.lib.nixosSystem {
          modules = [./hosts/skadi];
          specialArgs = { inherit inputs outputs; };
        };
        # Future Server
        bastet = nixpkgs.lib.nixosSystem {
          modules = [./hosts/bastet];
          specialArgs = { inherit inputs outputs; };
        };
      };
    };
}
