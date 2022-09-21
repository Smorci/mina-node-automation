{
  description = "Deploy VM to GCP with Mina Node running in container";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    arion.url = "github:hercules-ci/arion/master";
  };

  outputs = { self, nixpkgs, arion }: {

    devShells.x86_64-linux.default =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
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

      pkgs.writeShellApplication
        {
          name = "deploy-mina-node";

          runtimeInputs = [ terraform ];

          text = ''
            set -e

            TF_VAR_nixos_gce_image_path=$(echo ${self.nixosConfigurations.mina.config.system.build.googleComputeImage}/*.tar.gz)
            export TF_VAR_nixos_gce_image_path
            TF_VAR_nixos_gce_image=$(basename "$TF_VAR_nixos_gce_image_path")
            export TF_VAR_nixos_gce_image
            TF_VAR_nixos_gce_image_id=$(echo "$TF_VAR_nixos_gce_image" | sed 's|.raw.tar.gz$||;s|\.|-|g;s|_|-|g')
            export TF_VAR_nixos_gce_image_id
            TF_VAR_nixos_gce_image_family=$(echo "$TF_VAR_nixos_gce_image_id" | cut -d - -f1-4)
            export TF_VAR_nixos_gce_image_family
            
            pushd infrastructure
            terraform init
            terraform apply
            popd
          '';

        };

    packages.x86_64-linux.destroy =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        terraform = pkgs.terraform;
        gcloud = pkgs.google-cloud-sdk;
      in

      pkgs.writeShellApplication
        {
          name = "destroy-mina-node";

          runtimeInputs = [ terraform ];

          text = ''
            set -e

            TF_VAR_nixos_gce_image_path=$(echo ${self.nixosConfigurations.mina.config.system.build.googleComputeImage}/*.tar.gz)
            export TF_VAR_nixos_gce_image_path
            TF_VAR_nixos_gce_image=$(basename "$TF_VAR_nixos_gce_image_path")
            export TF_VAR_nixos_gce_image
            TF_VAR_nixos_gce_image_id=$(echo "$TF_VAR_nixos_gce_image" | sed 's|.raw.tar.gz$||;s|\.|-|g;s|_|-|g')
            export TF_VAR_nixos_gce_image_id
            TF_VAR_nixos_gce_image_family=$(echo "$TF_VAR_nixos_gce_image_id" | cut -d - -f1-4)
            export TF_VAR_nixos_gce_image_family
            
            pushd infrastructure
            terraform init
            terraform destroy
            popd
          '';

        };

    nixosConfigurations.mina = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          "${nixpkgs}/nixos/modules/virtualisation/google-compute-image.nix"
          arion.nixosModules.arion
          ./conf/configuration.nix
        ];
    };

  };
}
