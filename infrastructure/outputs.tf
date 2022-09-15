output "public_ip" {
  value = google_compute_address.static_ip.address
}

output "user" {
  value = data.google_client_openid_userinfo.me.email
}