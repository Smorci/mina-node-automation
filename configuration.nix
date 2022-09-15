{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    docker
    vim
    nettools
  ];

  documentation.enable = false;

  environment.etc = {
    mina-env = {
      enable = true;
      text = ''
        export PEER_LIST_URL=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt
      '';
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    ""
  ];

  networking.hostName = "mina-host";
  services.openssh.enable = true;
}
