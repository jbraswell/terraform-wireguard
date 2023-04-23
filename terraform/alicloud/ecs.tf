resource "alicloud_instance" "instance" {
  instance_name              = "wireguard-${terraform.workspace}"
  availability_zone          = "${var.region}a"
  security_groups            = alicloud_security_group.wireguard.*.id
  key_name                   = alicloud_ecs_key_pair.wireguard.id
  instance_type              = "ecs.n4.small"
  image_id                   = data.alicloud_images.ubuntu.ids[0]
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 10
  force_delete               = true
  user_data                  = data.cloudinit_config.wireguard.rendered
}

resource "alicloud_security_group" "wireguard" {
  name   = "wireguard-${terraform.workspace}"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_ssh_ingress" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.wireguard.id
  cidr_ip           = local.myip
}

resource "alicloud_security_group_rule" "allow_wireguard_ingress" {
  type              = "ingress"
  ip_protocol       = "udp"
  policy            = "accept"
  port_range        = "51820/51820"
  priority          = 2
  security_group_id = alicloud_security_group.wireguard.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_all_egress" {
  type              = "egress"
  ip_protocol       = "all"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 3
  security_group_id = alicloud_security_group.wireguard.id
  cidr_ip           = "0.0.0.0/0"
}

data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_22_04_x64*"
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "wireguard-${terraform.workspace}"
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = cidrsubnet(var.vpc_cidr_block, 8, 0)
  zone_id      = "${var.region}a"
  vswitch_name = "wireguard-${terraform.workspace}"
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
