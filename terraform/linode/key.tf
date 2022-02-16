resource "linode_sshkey" "wireguard" {
  label   = "wireguard-${terraform.workspace}"
  ssh_key = var.ssh_public_key
}
