resource "hostinger_vps_ssh_key" "wireguard" {
  name = "wireguard-${terraform.workspace}"
  key  = var.ssh_public_key
}
