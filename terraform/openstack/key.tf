resource "openstack_compute_keypair_v2" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  public_key = var.ssh_public_key
}
