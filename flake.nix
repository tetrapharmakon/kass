{
  description = "Build the KASS seminar page";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/24.11"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Bundled Jekyll environment (gemdir files: Gemfile, Gemfile.lock, gemset.nix)
      env = pkgs.bundlerEnv {
        name = "kass";
        ruby = pkgs.ruby;
        gemdir = ./.;
      };

      simple_app = name: text:
        let
          exec = pkgs.writeShellApplication { inherit name text; };
        in {
          type = "app";
          program = "${exec}/bin/${name}";
        };

    in {
      apps.${system} = {
        # nix run -> serve the site locally at http://localhost:4000/
        default = simple_app "serve_kass" ''
          ${env}/bin/jekyll serve "$@"
        '';

        # nix run .#build -> render the site into _site/
        build = simple_app "build_kass" ''
          ${env}/bin/jekyll build "$@"
        '';
      };
    };
}