{
  description = "A Nix-flake-based Python development environment";

  # GitHub URLs for the Nix inputs we're using
  inputs = {
    # Simply the greatest package repository on the planet
    nixpkgs.url = "github:NixOS/nixpkgs";
    # A set of helper functions for using flakes
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        python = pkgs.python310;

        pythonTools = with pkgs.python310Packages; [ pip virtualenv ];
      in {
        devShells = {
          default = pkgs.mkShell {
            # Packages included in the environment
            buildInputs = [ 
							python

	      pkgs.stdenv.cc.libc.static
	      pkgs.stdenv.cc.libc_dev
	      pkgs.stdenv.cc.cc.libgcc
	      pkgs.stdenv.cc
	      pkgs.zlib
	      pkgs.zlib.dev
						
						] ++ pythonTools;

            # Run when the shell is started up
            shellHook = ''
 export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
    ]}
	      # Setup the virtual environment if it doesn't already exist.
	      VENV=.cln
	      if test ! -d $VENV; then
		virtualenv $VENV
	      fi
	      source ./$VENV/bin/activate
              ${python}/bin/python --version
            '';
          };
        };
      });
}
