resource "brightbox_server" "wireguard" {
  name          = "wireguard-${terraform.workspace}"
  image         = data.brightbox_image.ubuntu.id
  zone          = var.region
  type          = "512mb.ssd"
  server_groups = [brightbox_server_group.wireguard.id]
  user_data     = data.cloudinit_config.wireguard.rendered
}

resource "brightbox_cloudip" "wireguard" {
  target = brightbox_server.wireguard.interface
  name   = "wireguard-${terraform.workspace}"
  port_translator {
    protocol = "tcp"
    incoming = 22
    outgoing = 22
  }
  port_translator {
    protocol = "udp"
    incoming = 51820
    outgoing = 51820
  }
}

resource "brightbox_server_group" "wireguard" {
  name        = "wireguard-${terraform.workspace}"
  description = "wireguard"
}

resource "brightbox_firewall_policy" "wireguard" {
  name         = "Terraform"
  server_group = brightbox_server_group.wireguard.id
}

resource "brightbox_firewall_rule" "ssh" {
  destination_port = 22
  protocol         = "tcp"
  source           = local.myip
  description      = "SSH"
  firewall_policy  = brightbox_firewall_policy.wireguard.id
}

resource "brightbox_firewall_rule" "wireguard" {
  destination_port = 51820
  protocol         = "udp"
  source           = "0.0.0.0/0"
  description      = "wireguard"
  firewall_policy  = brightbox_firewall_policy.wireguard.id
}

resource "brightbox_firewall_rule" "egress_tcp" {
  destination_port = "1-65535"
  protocol         = "tcp"
  destination      = "0.0.0.0/0"
  description      = "egress tcp"
  firewall_policy  = brightbox_firewall_policy.wireguard.id
}

resource "brightbox_firewall_rule" "egress_udp" {
  destination_port = "1-65535"
  protocol         = "udp"
  destination      = "0.0.0.0/0"
  description      = "egress udp"
  firewall_policy  = brightbox_firewall_policy.wireguard.id
}

data "brightbox_image" "ubuntu" {
  name        = "^ubuntu-jammy.*"
  arch        = "x86_64"
  official    = true
  most_recent = true
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
users:
  - name: wireguard
    ssh-authorized-keys:
      - ${var.ssh_public_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash
EOF
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
  }
}
