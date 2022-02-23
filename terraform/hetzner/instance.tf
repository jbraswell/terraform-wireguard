resource "hcloud_server" "wireguard" {
  name         = "wireguard-${terraform.workspace}"
  image        = "ubuntu-20.04"
  server_type  = "cpx11"
  location     = var.region
  firewall_ids = [hcloud_firewall.wireguard.id]
  ssh_keys     = [hcloud_ssh_key.wireguard.id]
  user_data    = data.cloudinit_config.wireguard.rendered
}

resource "hcloud_firewall" "wireguard" {
  name = "wireguard-${terraform.workspace}"
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = [local.myip]
  }

  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "51820"
    source_ips = [local.myip]
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
EOF
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
  }
}
