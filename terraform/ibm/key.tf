resource "ibm_is_ssh_key" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  public_key = var.ssh_public_key
}
