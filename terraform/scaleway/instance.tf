resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_server" "wireguard" {
  name              = "wireguard-${terraform.workspace}"
  type              = "DEV1-S"
  image             = "ubuntu_focal"
  ip_id             = scaleway_instance_ip.public_ip.id
  security_group_id = scaleway_instance_security_group.wireguard.id

  user_data = {
    cloud-init = data.cloudinit_config.wireguard.rendered
  }
}

resource "scaleway_instance_security_group" "wireguard" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action   = "accept"
    port     = "22"
    protocol = "TCP"
    ip       = local.myip
  }

  inbound_rule {
    action   = "accept"
    protocol = "UDP"
    port     = "51820"
  }

  outbound_rule {
    action   = "accept"
    protocol = "ANY"
    ip_range = "0.0.0.0/0"
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
