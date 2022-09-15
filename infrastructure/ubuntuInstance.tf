resource "google_compute_instance" "mina_host" {
  name         = "mina-host"
  machine_type = var.linux_instance_type
  zone         = var.project_zone
  hostname     = "mina-host.mina.com"
  tags         = ["mina-host"]

  boot_disk {
    initialize_params {
      image = var.ubuntu-pro-2004-sku
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.network-subnet.name
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
    startup-script = <<-EOF
      #cloud-config
      runcmd:
        - |
          # We set root as /dev/disk/by-label/nixos in server.nix, make sure this is available.
          ROOT="$(mount | grep ' / ' | cut -d ' ' -f 1)"
          e2label "$ROOT" nixos
          # Infect!
          curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect \
            | NIX_CHANNEL=nixos-21.11 bash 2>&1 \
            | tee /tmp/infect.log
    EOF
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = ".ssh/google_compute_engine"
  file_permission = "0600"
}

