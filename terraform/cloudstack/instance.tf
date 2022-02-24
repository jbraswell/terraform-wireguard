resource "cloudstack_instance" "wireguard" {
  name               = "wireguard-${terraform.workspace}"
  service_offering   = "Tiny"
  template           = "Linux Ubuntu 20.04 LTS 64-bit"
  zone               = var.region
  security_group_ids = [cloudstack_security_group.wireguard.id]
  keypair            = cloudstack_ssh_keypair.wireguard.id
  user_data          = data.cloudinit_config.wireguard.rendered
}

resource "cloudstack_security_group" "wireguard" {
  name        = "wireguard-${terraform.workspace}"
  description = "Allow access to ssh and wireguard"
}

resource "cloudstack_security_group_rule" "wireguard" {
  security_group_id = cloudstack_security_group.wireguard.id

  rule {
    protocol     = "tcp"
    ports        = ["22"]
    traffic_type = "ingress"
    cidr_list    = [local.myip]
  }

  rule {
    protocol     = "udp"
    ports        = ["51820"]
    traffic_type = "ingress"
    cidr_list    = [local.myip]
  }

  rule {
    protocol     = "tcp"
    ports        = ["1-65535"]
    traffic_type = "egress"
    cidr_list    = ["0.0.0.0/0"]
  }

  rule {
    protocol     = "udp"
    ports        = ["1-65535"]
    traffic_type = "egress"
    cidr_list    = ["0.0.0.0/0"]
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
