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
        gcloud = pkgs.google-cloud-sdk;
      in
      pkgs.mkShell {
        nativeBuildInputs = [ gcloud terraform ];
      };

    packages.x86_64-linux.default =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        terraform = pkgs.terraform;
        gcloud = pkgs.google-cloud-sdk;
      in


      # nixosConfigurations.server1.config.system.build.googleComputeImage {
        #   configFile = [ ./configuration.nix ];
        # };

      pkgs.writeShellApplication
        {
          name = "deploy-mina-node";

          runtimeInputs = [ terraform ];

          text = ''
            img_path=$(echo ${self.nixosConfigurations.server1.config.system.build.googleComputeImage}/*.tar.gz)
            img_name=$(basename "$img_path")
          '';
        };

    nixosConfigurations.server1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          "${nixpkgs}/nixos/modules/virtualisation/google-compute-image.nix"
          ./configuration.nix
        ];
    };

    #     apps.x86_64-linux.default = {
    #       type = "app";
    #       program = "${}";
    # };

  };
}
