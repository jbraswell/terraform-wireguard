resource "contabo_secret" "wireguard" {
  name  = "wireguard-${terraform.workspace}"
  type  = "ssh"
  value = var.ssh_public_key
}
