output wireguard_public_ip {
  value = digitalocean_droplet.wireguard.ipv4_address
}
