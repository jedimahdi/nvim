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
        treefmtWrapper = treefmtEval.config.build.wrapper;
      in {
        formatter = treefmtWrapper;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.stylua
            pkgs.alejandra
            treefmtWrapper
          ];
        };
      }
    );
}
