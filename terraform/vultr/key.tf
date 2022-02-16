resource "vultr_ssh_key" "wireguard" {
  name    = "wireguard-${terraform.workspace}"
  ssh_key = var.ssh_public_key
}
