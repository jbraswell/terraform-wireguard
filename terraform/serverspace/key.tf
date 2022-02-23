resource "serverspace_ssh" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  public_key = var.ssh_public_key
}
