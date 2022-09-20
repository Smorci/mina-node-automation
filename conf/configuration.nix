{ config, pkgs, ... }:

{

  # imports = [ "${modulesPath}/virtualisation/qemu-vm.nix" ];

  virtualisation = {
    docker.enable = true;
    # memorySize = 8192;
    # diskSize = 100000;
    # forwardPorts = [
    #   { from = "host"; host.port = 8302; guest.port = 8302; }
    # ];
  };

  environment.systemPackages = with pkgs; [
    arion
    vim
    nettools
  ];

  documentation.enable = false;

  environment.etc = {
    mina-env = {
      text = ''
        export PEER_LIST_URL=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt
      '';
    };
    arion-compose = {
      source = ./../arion/arion-compose.nix;
      target = "arion-compose.nix";
      mode = "0644";
    };
    arion-pkgs = {
      source = ./../arion/arion-pkgs.nix;
      target = "arion-pkgs.nix";
      mode = "0644";
    };
  };

  system.activationScripts = {
    mina-conf = {
      text = ''
        mkdir -p /etc/mina-config
      '';
    };
    keys = {
      text = ''
        mkdir -p /etc/keys
      '';
    };
  };

  users = {
    users.root.openssh.authorizedKeys.keys = [
      ""
    ];
  };

  networking.hostName = "mina-host";
  services.openssh.enable = true;
}
