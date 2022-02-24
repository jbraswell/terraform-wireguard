resource "openstack_compute_instance_v2" "wireguard" {
  name              = "wireguard-${terraform.workspace}"
  image_id          = data.openstack_images_image_v2.ubuntu.id
  flavor_name       = var.flavor_name
  availability_zone = data.openstack_compute_availability_zones_v2.zones.names[0]
  key_pair          = openstack_compute_keypair_v2.wireguard.id
  security_groups   = [openstack_networking_secgroup_v2.wireguard.name]
  user_data         = data.cloudinit_config.wireguard.rendered
}

resource "openstack_networking_secgroup_v2" "wireguard" {
  name        = "wireguard-${terraform.workspace}"
  description = "Allow access to ssh and wireguard"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = local.myip
  security_group_id = openstack_networking_secgroup_v2.wireguard.id
}

resource "openstack_networking_secgroup_rule_v2" "wireguard" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 51820
  port_range_max    = 51820
  remote_ip_prefix  = local.myip
  security_group_id = openstack_networking_secgroup_v2.wireguard.id
}

resource "openstack_networking_secgroup_rule_v2" "egress_tcp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.wireguard.id
}

resource "openstack_networking_secgroup_rule_v2" "egress_udp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.wireguard.id
}

data "openstack_images_image_v2" "ubuntu" {
  name        = var.image_name
  most_recent = true
}

data "openstack_compute_availability_zones_v2" "zones" {
  region = var.region
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
