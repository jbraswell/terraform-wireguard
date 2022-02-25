resource "exoscale_compute_instance" "wireguard" {
  name               = "wireguard-${terraform.workspace}"
  zone               = var.region
  type               = "standard.tiny"
  template_id        = data.exoscale_compute_template.ubuntu.id
  disk_size          = 10
  security_group_ids = [exoscale_security_group.wireguard.id]
  elastic_ip_ids     = [exoscale_elastic_ip.wireguard.id]
  ssh_key            = exoscale_ssh_key.wireguard.id
  user_data          = data.cloudinit_config.wireguard.rendered
}

resource "exoscale_elastic_ip" "wireguard" {
  zone = var.region

  healthcheck {
    mode         = "tcp"
    port         = 22
    interval     = 5
    timeout      = 3
    strikes_ok   = 2
    strikes_fail = 3
  }
}

resource "exoscale_security_group" "wireguard" {
  name             = "wireguard-${terraform.workspace}"
  description      = "Allow access to ssh and wireguard"
  external_sources = [local.myip]
}

resource "exoscale_security_group_rules" "wireguard" {
  security_group = exoscale_security_group.wireguard.name

  ingress {
    protocol  = "TCP"
    ports     = ["22"]
    cidr_list = [local.myip]
  }

  ingress {
    protocol  = "UDP"
    ports     = ["51820"]
    cidr_list = ["0.0.0.0/0"]
  }

  egress {
    protocol  = "TCP"
    ports     = ["1-65535"]
    cidr_list = ["0.0.0.0/0", "::/0"]
  }

  egress {
    protocol  = "UDP"
    ports     = ["1-65535"]
    cidr_list = ["0.0.0.0/0", "::/0"]
  }
}

data "exoscale_compute_template" "ubuntu" {
  zone = var.region
  name = "Linux Ubuntu 20.04 LTS 64-bit"
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
