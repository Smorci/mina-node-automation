resource "google_compute_instance" "vm_instance_public" {
  name         = "mina-host"
  machine_type = var.linux_instance_type
  zone         = var.project_zone
  hostname     = "mina-host.mina.com"
  tags         = ["mina-host"]  
  
  boot_disk {
    initialize_params {
      image = var.ubuntu-pro-1804-sku
    }
  }  
  
  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.network-subnet.name
    access_config { }
  }
}