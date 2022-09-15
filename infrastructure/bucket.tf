resource "google_storage_bucket" "nixos_image" {
  name          = "nixos-image"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true
}
