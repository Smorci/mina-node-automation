{ pkgs, ... }:
{
  config.services = {

    mina = {
      service = {
        image = "minaprotocol/mina-daemon:1.3.0-9b0369c-bullseye-mainnet";
        useHostStore = true;
        restart = "always";
        container_name = "mina";
        volumes = [ "/etc/mina-env:/entrypoint.d/mina-env:ro" "/etc/keys:/keys:ro" "/etc/mina-config:/root/.mina-config" ];
        ports = [
          "8302:8302" # host:container
        ];
      };
    };
  };
}