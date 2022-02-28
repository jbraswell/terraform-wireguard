resource "cloudscale_server" "wireguard" {
  name           = "wireguard-${terraform.workspace}"
  zone_slug      = var.region
  flavor_slug    = "flex-2"
  image_slug     = "ubuntu-20.04"
  volume_size_gb = 10
  ssh_keys       = [var.ssh_public_key]
  user_data      = data.cloudinit_config.wireguard.part[0].content

  interfaces {
    type = "public"
  }
}

data "cloudinit_config" "wireguard" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = <<EOF
#cloud-config

packages:
  - wireguard
write_files:
  - path: /tmp/wg-setup.sh
    permissions: 0744
    owner: root
    content: |
      ${indent(6, templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf }))}
      ufw default deny incoming
      ufw default allow outgoing
      ufw allow from ${local.myip} to any proto tcp port 22
      ufw allow 51820/udp
      ufw enable
runcmd:
  - bash /tmp/wg-setup.sh
EOF
  }
}
