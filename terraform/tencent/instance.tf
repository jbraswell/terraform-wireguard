resource "tencentcloud_instance" "wireguard" {
  instance_name     = "wireguard-${terraform.workspace}"
  availability_zone = "${var.region}-1"
  image_id          = data.tencentcloud_image.ubuntu.image_id
  security_groups   = [tencentcloud_security_group.wireguard.id]
  instance_type     = "S2.SMALL1"
  system_disk_size  = 50
  hostname          = "wireguard"
  key_name          = tencentcloud_key_pair.wireguard.id
  user_data         = data.cloudinit_config.wireguard.rendered
}

resource "tencentcloud_security_group" "wireguard" {
  name        = "wireguard-${terraform.workspace}"
  description = "wireguard-${terraform.workspace}"
}

resource "tencentcloud_security_group_rule" "ssh" {
  security_group_id = tencentcloud_security_group.wireguard.id
  type              = "ingress"
  cidr_ip           = local.myip
  ip_protocol       = "TCP"
  port_range        = "22"
  policy            = "ACCEPT"
  description       = "ssh"
}

resource "tencentcloud_security_group_rule" "wireguard" {
  security_group_id = tencentcloud_security_group.wireguard.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "UDP"
  port_range        = "51820"
  policy            = "ACCEPT"
  description       = "wireguard"
}

resource "tencentcloud_security_group_rule" "egress_tcp" {
  security_group_id = tencentcloud_security_group.wireguard.id
  type              = "egress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "TCP"
  port_range        = "1-65535"
  policy            = "ACCEPT"
  description       = "egress tcp"
}

resource "tencentcloud_security_group_rule" "egress_udp" {
  security_group_id = tencentcloud_security_group.wireguard.id
  type              = "egress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "UDP"
  port_range        = "1-65535"
  policy            = "ACCEPT"
  description       = "egress udp"
}

resource "tencentcloud_eip" "wireguard" {
  name = "wireguard-${terraform.workspace}"
}

resource "tencentcloud_eip_association" "wireguard" {
  eip_id      = tencentcloud_eip.wireguard.id
  instance_id = tencentcloud_instance.wireguard.id
}

data "tencentcloud_image" "ubuntu" {
  os_name = "Ubuntu Server 20.04 LTS 64bit"

  filter {
    name   = "image-type"
    values = ["PUBLIC_IMAGE"]
  }
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
