variable "ubuntu-pro-2004-sku" {
  type        = string
  description = "SKU for Ubuntu PRO LTS"
  default     = "ubuntu-os-pro-cloud/ubuntu-pro-2004-lts"
}

variable "nixos_gce_image" {
  type        = string
  description = "Custom Nixos Image for GCP"
}

variable "linux_instance_type" {
  type        = string
  description = "VM instance type for Linux Server"
  default     = "c2-standard-8"
}

variable "project_credentials" {
  type        = string
  description = "A relative path to the service account credential file"
}

variable "project_region" {
  type        = string
  description = "Google Cloud Project region"
  default     = "us-central1"
}

variable "project_zone" {
  type        = string
  description = "Google Cloud Project zone"
  default     = "us-central1-c"
}

variable "project_name" {
  type        = string
  description = "Name of the Google Cloud Project"
  default     = "mina-node-host"
}

variable "network_subnet_cidr" {
  type        = string
  description = "The CIDR for the network subnet"
}
