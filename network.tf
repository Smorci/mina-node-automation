variable "network-subnet-cidr" {
  type = string
  description = "The CIDR for the network subnet"
}

resource "google_compute_network" "vpc" {
  name = "mina-host-vpc"
  auto_create_subnetworks = false
  routing_mode = "GLOBAL"
}

resource "google_compute_subnetwork" "network-subnet" {
  name = "mina-host-subnet"
  ip_cidr_range = var.network-subnet-cidr
  network = google_compute_network.vpc.name
  region = var.project-region
}

resource "google_compute_firewall" "allow-http" {
  name = "mina-host-allow-http"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports = ["22", "8301", "8302"]
  }

  direction = "INGRESS"

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["mina-host"]
}