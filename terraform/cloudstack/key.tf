resource "cloudstack_ssh_keypair" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  public_key = var.ssh_public_key
}
