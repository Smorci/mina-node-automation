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
        arion = pkgs.arion;
        gcloud = pkgs.google-cloud-sdk;
      in

      pkgs.writeShellApplication
        {
          name = "deploy-mina-node";

          runtimeInputs = [ terraform arion ];

          text = ''
            nix build ".#nixosConfigurations.server1.config.system.build.googleComputeImage"
          
            TF_VAR_nixos_gce_image_path=$(echo ${self.nixosConfigurations.server1.config.system.build.googleComputeImage}/*.tar.gz)
            TF_VAR_nixos_gce_image=$(basename "$TF_VAR_nixos_gce_image_path")
            TF_VAR_nixos_gce_image_id=$(echo "$TF_VAR_nixos_gce_image" | sed 's|.raw.tar.gz$||;s|\.|-|g;s|_|-|g')
            TF_VAR_nixos_gce_image_family=$(echo "$TF_VAR_nixos_gce_image_id" | cut -d - -f1-4)

            pushd infrastructure
            terraform init -upgrade
            terraform apply \
            -var nixos_gce_image_path="$TF_VAR_nixos_gce_image_path" \
            -var nixos_gce_image="$TF_VAR_nixos_gce_image" \
            -var nixos_gce_image_id="$TF_VAR_nixos_gce_image_id" \
            -var nixos_gce_image_family="$TF_VAR_nixos_gce_image_family"
            popd
          '';

        };

    nixosConfigurations.server1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          "${nixpkgs}/nixos/modules/virtualisation/google-compute-image.nix"
          ./conf/configuration.nix
        ];
    };

    #     apps.x86_64-linux.default = {
    #       type = "app";
    #       program = "${}";
    # };

  };
}
