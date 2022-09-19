resource "google_compute_image" "nixos_gce_image" {
  name   = var.nixos_gce_image_id
  family = var.nixos_gce_image_family

  raw_disk {
    source = google_storage_bucket_object.nixos_gce_image.self_link
  }
}
