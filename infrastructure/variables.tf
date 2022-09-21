variable "nixos_gce_image" {
  type        = string
  description = "Custom Nixos Image for GCP"
}

variable "nixos_gce_image_path" {
  type        = string
  description = "Nix store path to custom Nixos Image for GCP"
}

variable "nixos_gce_image_id" {
  type        = string
  description = "Id of custom Nixos Image for GCP"
}

variable "nixos_gce_image_family" {
  type        = string
  description = "Family of custom Nixos Image for GCP"
}

variable "linux_instance_type" {
  type        = string
  description = "VM instance type for Linux Server"
  default     = "c2-standard-8" # Mina has been tested on this instance type
}

variable "project_credentials" {
  type        = string
  description = "The absolute path to the service account credential file on your local system"
}

variable "project_region" {
  type        = string
  description = "Google Cloud Project region"
}

variable "project_zone" {
  type        = string
  description = "Google Cloud Project zone"
}

variable "project_name" {
  type        = string
  description = "Name of the Google Cloud Project"
}

variable "network_subnet_cidr" {
  type        = string
  description = "The CIDR for the network subnet"
}
