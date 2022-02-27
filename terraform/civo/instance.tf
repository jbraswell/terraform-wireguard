resource "civo_instance" "wireguard" {
  hostname     = "wireguard.tf"
  region       = var.region
  size         = "g3.xsmall"
  disk_image   = data.civo_disk_image.ubuntu.diskimages[0].id
  firewall_id  = civo_firewall.wireguard.id
  sshkey_id    = civo_ssh_key.wireguard.id
  initial_user = "wireguard"
  tags         = ["wireguard-${terraform.workspace}"]
  notes        = "wireguard"
  script       = <<EOF
#!/bin/bash
apt-get -y install wireguard

${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
EOF

}

data "civo_network" "default" {
  label  = "default"
  region = var.region
}

resource "civo_firewall" "wireguard" {
  name                 = "wireguard-${terraform.workspace}"
  region               = var.region
  network_id           = data.civo_network.default.id
  create_default_rules = false
}

resource "civo_firewall_rule" "ssh" {
  region      = var.region
  action      = "allow"
  firewall_id = civo_firewall.wireguard.id
  protocol    = "tcp"
  start_port  = "22"
  end_port    = "22"
  cidr        = [local.myip]
  direction   = "ingress"
  label       = "ssh"
  depends_on  = [civo_firewall.wireguard]
}

resource "civo_firewall_rule" "wireguard" {
  region      = var.region
  action      = "allow"
  firewall_id = civo_firewall.wireguard.id
  protocol    = "udp"
  start_port  = "51820"
  end_port    = "51820"
  cidr        = ["0.0.0.0/0"]
  direction   = "ingress"
  label       = "wireguard"
  depends_on  = [civo_firewall.wireguard]
}

resource "civo_firewall_rule" "egress_tcp" {
  region      = var.region
  action      = "allow"
  firewall_id = civo_firewall.wireguard.id
  protocol    = "tcp"
  start_port  = "1"
  end_port    = "65535"
  cidr        = ["0.0.0.0/0"]
  direction   = "egress"
  label       = "egress tcp"
  depends_on  = [civo_firewall.wireguard]
}

resource "civo_firewall_rule" "egress_udp" {
  region      = var.region
  action      = "allow"
  firewall_id = civo_firewall.wireguard.id
  protocol    = "udp"
  start_port  = "1"
  end_port    = "65535"
  cidr        = ["0.0.0.0/0"]
  direction   = "egress"
  label       = "egress udp"
  depends_on  = [civo_firewall.wireguard]
}

data "civo_disk_image" "ubuntu" {
  filter {
    key    = "name"
    values = ["ubuntu-focal"]
  }
}
