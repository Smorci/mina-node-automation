terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.36.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
  required_version = ">= 0.12"
}

provider "tls" {

}

provider "google" {
  credentials = file(var.project_credentials)

  project = var.project_name
  region  = var.project_region
  zone    = var.project_zone
}
