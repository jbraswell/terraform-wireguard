resource "huaweicloud_compute_instance" "wireguard" {
  name               = "wireguard-${terraform.workspace}"
  image_id           = data.huaweicloud_images_image.ubuntu.id
  flavor_id          = "s6.small.1"
  key_pair           = huaweicloud_kps_keypair.wireguard.name
  security_group_ids = [huaweicloud_networking_secgroup.wireguard.id]
  user_data          = data.cloudinit_config.wireguard.rendered

  network {
    uuid = huaweicloud_vpc_subnet.wireguard.id
  }
}

resource "huaweicloud_vpc" "wireguard" {
  name = "wireguard-${terraform.workspace}"
  cidr = var.vpc_cidr_block
}

resource "huaweicloud_vpc_subnet" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  cidr       = cidrsubnet(var.vpc_cidr_block, 8, 0)
  gateway_ip = cidrhost(cidrsubnet(var.vpc_cidr_block, 8, 0), 1)
  vpc_id     = huaweicloud_vpc.wireguard.id
}

resource "huaweicloud_networking_secgroup" "wireguard" {
  name                 = "wireguard-${terraform.workspace}"
  delete_default_rules = true
}

resource "huaweicloud_networking_secgroup_rule" "ssh" {
  security_group_id = huaweicloud_networking_secgroup.wireguard.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  ports             = "22"
  remote_ip_prefix  = local.myip
  action            = "allow"
}

resource "huaweicloud_networking_secgroup_rule" "wireguard" {
  security_group_id = huaweicloud_networking_secgroup.wireguard.id
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  ports             = "51820"
  remote_ip_prefix  = "0.0.0.0/0"
  action            = "allow"
}

resource "huaweicloud_networking_secgroup_rule" "egress" {
  security_group_id = huaweicloud_networking_secgroup.wireguard.id
  direction         = "egress"
  ethertype         = "IPv4"
  action            = "allow"
}

resource "huaweicloud_vpc_eip" "wireguard" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    share_type  = "PER"
    name        = "wireguard-${terraform.workspace}"
    size        = 10
    charge_mode = "traffic"
  }
}

resource "huaweicloud_compute_eip_associate" "wireguard" {
  public_ip   = huaweicloud_vpc_eip.wireguard.address
  instance_id = huaweicloud_compute_instance.wireguard.id
}

data "huaweicloud_images_image" "ubuntu" {
  name        = "Ubuntu 22.04 server 64bit"
  visibility  = "public"
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
EOF
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
  }
}
