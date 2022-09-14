terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
  required_version = ">= 0.12"
}

provider "google" {
  credentials = file(var.project_credentials)

  project = var.project_name
  region  = var.project_region
  zone    = var.project_zone
}
