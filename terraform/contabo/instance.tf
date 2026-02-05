resource "contabo_instance" "wireguard" {
  display_name = "wireguard-${terraform.workspace}"
  product_id   = "V40" # VPS XS NVME 2vCPU/4GB Ram
  region       = "EU"
  period       = 1 # 1month period
  ssh_keys     = [tonumber(contabo_secret.wireguard.id)]
  user_data    = <<EOF
#cloud-config
packages:
  - wireguard
runcmd:
  - |
    ${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
EOF
}

data "contabo_image" "ubuntu_22_04" {
  id = "afecbb85-e2fc-46f0-9684-b46b1faf00bb"
}
