resource "tencentcloud_key_pair" "wireguard" {
  key_name   = "wireguard_${terraform.workspace}"
  public_key = var.ssh_public_key
}
