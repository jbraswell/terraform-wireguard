resource "ionoscloud_server" "wireguard" {
  name              = "wireguard-${terraform.workspace}"
  datacenter_id     = ionoscloud_datacenter.wireguard.id
  cores             = 1
  ram               = 1024
  cpu_family        = ionoscloud_datacenter.wireguard.cpu_architecture[0].cpu_family
  availability_zone = "AUTO"
  image_name        = data.ionoscloud_image.ubuntu.name
  ssh_key_path      = [var.ssh_key_path]

  nic {
    lan             = ionoscloud_lan.wireguard.id
    dhcp            = true
    firewall_active = true
    name            = "wireguard-${terraform.workspace}"
    ips             = [ionoscloud_ipblock.wireguard.ips[0]]
  }

  volume {
    name      = "wireguard-${terraform.workspace}"
    size      = 50
    disk_type = "HDD"
    user_data = data.cloudinit_config.wireguard.rendered
  }
}

resource "ionoscloud_firewall" "ssh" {
  datacenter_id    = ionoscloud_datacenter.wireguard.id
  server_id        = ionoscloud_server.wireguard.id
  nic_id           = ionoscloud_server.wireguard.primary_nic
  protocol         = "TCP"
  name             = "ssh"
  port_range_start = 22
  port_range_end   = 22
  source_ip        = local.myip
}

resource "ionoscloud_firewall" "wireguard" {
  datacenter_id    = ionoscloud_datacenter.wireguard.id
  server_id        = ionoscloud_server.wireguard.id
  nic_id           = ionoscloud_server.wireguard.primary_nic
  protocol         = "UDP"
  name             = "ssh"
  port_range_start = 51820
  port_range_end   = 51820
  source_ip        = "0.0.0.0"
}

resource "ionoscloud_lan" "wireguard" {
  datacenter_id = ionoscloud_datacenter.wireguard.id
  name          = "wireguard-${terraform.workspace}"
  public        = true
}

resource "ionoscloud_datacenter" "wireguard" {
  name        = "wireguard-${terraform.workspace}"
  location    = var.region
  description = "wireguard-${terraform.workspace}"
}

resource "ionoscloud_ipblock" "wireguard" {
  name     = "wireguard-${terraform.workspace}"
  location = ionoscloud_datacenter.wireguard.location
  size     = 1
}

data "ionoscloud_image" "ubuntu" {
  name       = "ubuntu"
  type       = "HDD"
  version    = "20.04-LTS-server"
  location   = var.region
  cloud_init = "V1"
}

data "cloudinit_config" "wireguard" {
  gzip          = false
  base64_encode = true

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
