resource "metal_project_ssh_key" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  public_key = var.ssh_public_key
  project_id = metal_project.wireguard.id
}
