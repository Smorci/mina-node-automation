output "ssh_comand" {
  value = "ssh -i infrastructure/.ssh/google_compute_engine ${split("@", data.google_client_openid_userinfo.me.email)[0]}@${google_compute_address.static_ip.address}"
}

