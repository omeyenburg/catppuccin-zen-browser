{
  description = "Run whiskers templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};

        run-whiskers = pkgs.writeShellApplication {
          name = "run-whiskers";
          runtimeInputs = [
            pkgs.catppuccin-whiskers
          ];
          text = ''
            set -e
            whiskers -o plain templates/userChrome.tera
            whiskers -o plain templates/userContent.tera
            whiskers -o plain templates/zen-logo.tera
          '';
        };
      in {
        apps.default = {
          type = "app";
          program = "${run-whiskers}/bin/run-whiskers";
        };
      }
    );
}
