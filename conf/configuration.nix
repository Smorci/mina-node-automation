{ config, pkgs, ... }:

{

  virtualisation = {
    docker.enable = true;
    arion = {
      backend = "docker";
      projects.mina.settings = {
        imports = [ ./../arion/arion-compose.nix ];
      };
    };
  };

  networking = {
    nameservers = [ "8.8.8.8" ];
    hostName = "mina-host";
  };

  environment.systemPackages = with pkgs; [
    arion
    vim
    nettools
    dig
  ];

  environment.etc = {
    mina-env = {
      text = ''
        export PEER_LIST_URL=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt
      '';
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

  services.openssh.enable = true;
  documentation.enable = false;

  system.stateVersion = "22.11";
}
