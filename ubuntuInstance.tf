variable "ubuntu-pro-1804-sku" {
  type        = string
  description = "SKU for Ubuntu PRO 18.04 LTS"
  default     = "ubuntu-os-pro-cloud/ubuntu-pro-1804-lts"
}

variable "linux-instance-type" {
  type        = string
  description = "VM instance type for Linux Server"
  default     = "c2-standard-8"
}

resource "google_compute_instance" "vm_instance_public" {
  name         = "mina-host"
  machine_type = var.linux-instance-type
  zone         = var.project-zone
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