resource "aws_key_pair" "wireguard" {
  key_name   = "wireguard-${terraform.workspace}"
  public_key = var.ssh_public_key
}
