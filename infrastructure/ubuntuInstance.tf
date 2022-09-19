resource "google_compute_instance" "mina_host" {
  name         = "mina-host"
  machine_type = var.linux_instance_type
  zone         = var.project_zone
  hostname     = "mina-host.mina.com"
  tags         = ["mina-host"]

  boot_disk {
    initialize_params {
      image = google_compute_image.nixos_gce_image.self_link
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

