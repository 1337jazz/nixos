{
  description = "idk what i'm doing honestly";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix }:
    let 
      lib = nixpkgs.lib;
      pkgs-unstable = import nixpkgs-unstable { system = "x86_64-linux"; };
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./configuration.nix
	  home-manager.nixosModules.home-manager
	  { home-manager.extraSpecialArgs = { inherit pkgs-unstable; }; }
	  stylix.nixosModules.stylix
	 ];
      };
    };
  };
}
