resource "alicloud_ecs_key_pair" "wireguard" {
  key_pair_name = "wireguard-${terraform.workspace}"
  public_key    = var.ssh_public_key
}
