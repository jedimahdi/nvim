{
  description = "Neovim Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    utils,
    treefmt-nix,
    ...
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in {
        formatter = treefmtEval.config.build.wrapper;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.stylua
            pkgs.alejandra
          ];
        };
      }
    );
}
