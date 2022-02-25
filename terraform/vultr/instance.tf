data "vultr_os" "ubuntu" {
  filter {
    name   = "name"
    values = ["Ubuntu 20.04 x64"]
  }
}

resource "vultr_instance" "wireguard" {
  label             = "wireguard-${terraform.workspace}"
  plan              = "vc2-1c-1gb"
  region            = var.region
  os_id             = data.vultr_os.ubuntu.id
  ssh_key_ids       = [vultr_ssh_key.wireguard.id]
  reserved_ip_id    = vultr_reserved_ip.wireguard.id
  firewall_group_id = vultr_firewall_group.wireguard.id
  user_data         = data.cloudinit_config.wireguard.rendered
}

resource "vultr_reserved_ip" "wireguard" {
  label   = "wireguard-${terraform.workspace}"
  region  = var.region
  ip_type = "v4"
}

resource "vultr_firewall_group" "wireguard" {
  description = "wireguard-${terraform.workspace}"
}

resource "vultr_firewall_rule" "wireguard" {
  firewall_group_id = vultr_firewall_group.wireguard.id
  protocol          = "udp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = "51820"
  notes             = "wireguard"
}

resource "vultr_firewall_rule" "ssh" {
  firewall_group_id = vultr_firewall_group.wireguard.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = local.myip
  subnet_size       = 32
  port              = "22"
  notes             = "ssh"
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
    content      = <<EOF
#!/bin/bash
ufw allow 51820/udp
EOF
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
  }
}
