{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
  };

  outputs = { self, nixpkgs }: {

    devShells.x86_64-linux.default =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        programPython = pkgs.python3;
        terraform = pkgs.terraform;
        packer = pkgs.packer;
        pythonWithPackages = programPython.withPackages (ps: with ps; [
          matplotlib
        ]);
      in
      pkgs.mkShell {
        nativeBuildInputs = [ pythonWithPackages terraform packer ];
        shellHook = ''
          PYTHONPATH=${pythonWithPackages}/${pythonWithPackages.sitePackages}
        '';
      };
  };
}
