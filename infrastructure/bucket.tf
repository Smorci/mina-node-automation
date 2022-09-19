resource "google_storage_bucket" "nixos_image_bucket" {

  name          = "nixos-image-bucket"
  location      = "US"
  force_destroy = true
  project       = var.project_name

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "nixos_gce_image" {
  name   = var.nixos_gce_image
  source = var.nixos_gce_image_path
  bucket = google_storage_bucket.nixos_image_bucket.name
}
