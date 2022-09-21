resource "google_compute_network" "vpc" {
  name                    = "mina-host-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_address" "static_ip" {
  name = "mina-host-ip"
}

resource "google_compute_subnetwork" "network-subnet" {
  name          = "mina-host-subnet"
  ip_cidr_range = var.network_subnet_cidr
  network       = google_compute_network.vpc.name
  region        = var.project_region
}

resource "google_compute_firewall" "allow-ssh-mina" {
  name    = "allow-ssh-mina"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22", "8301", "8302"]
  }

  direction = "INGRESS"

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["mina-host"]
}
