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
  credentials = file(var.project-credentials)

  project = var.project-name
  region  = var.project-region
  zone    = var.project-zone
}

variable "project-credentials" {
  type = string
  description = "A relative path to the service account credential file"
}

variable "project-region" {
  type = string
  description = "Google Cloud Project region"
  default = "us-central1"
}

variable "project-zone" {
  type = string
  description = "Google Cloud Project zone"
  default = "us-central1-c"
}

variable "project-name" {
  type = string
  description = "Name of the Google Cloud Project"
  default = "mina-node-host"
}
