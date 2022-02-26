resource "ibm_is_instance" "wireguard" {
  name    = "wireguard-${terraform.workspace}"
  image   = data.ibm_is_image.ubuntu.id
  profile = "cx2-2x4"

  primary_network_interface {
    subnet          = ibm_is_subnet.wireguard.id
    security_groups = [ibm_is_security_group.wireguard.id]
  }

  vpc       = ibm_is_vpc.wireguard.id
  zone      = "${var.region}-1"
  keys      = [ibm_is_ssh_key.wireguard.id]
  user_data = data.cloudinit_config.wireguard.rendered
}

resource "ibm_is_floating_ip" "wireguard" {
  name   = "wireguard-${terraform.workspace}"
  target = ibm_is_instance.wireguard.primary_network_interface[0].id
}

resource "ibm_is_security_group" "wireguard" {
  name = "wireguard-${terraform.workspace}"
  vpc  = ibm_is_vpc.wireguard.id
}

resource "ibm_is_security_group_rule" "ssh" {
  group     = ibm_is_security_group.wireguard.id
  direction = "inbound"
  remote    = local.myip
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "wireguard" {
  group     = ibm_is_security_group.wireguard.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  udp {
    port_min = 51820
    port_max = 51820
  }
}

resource "ibm_is_security_group_rule" "egress_udp" {
  group     = ibm_is_security_group.wireguard.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  udp {
    port_min = 1
    port_max = 65535
  }
}

resource "ibm_is_security_group_rule" "egress_tcp" {
  group     = ibm_is_security_group.wireguard.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 1
    port_max = 65535
  }
}

resource "ibm_is_vpc" "wireguard" {
  name = "wireguard-${terraform.workspace}"
}

resource "ibm_is_vpc_address_prefix" "wireguard" {
  cidr = var.subnet_cidr_block
  name = "wireguard-${terraform.workspace}"
  vpc  = ibm_is_vpc.wireguard.id
  zone = "${var.region}-1"
}

resource "ibm_is_subnet" "wireguard" {
  ipv4_cidr_block = var.subnet_cidr_block
  name            = "wireguard-${terraform.workspace}"
  vpc             = ibm_is_vpc.wireguard.id
  zone            = "${var.region}-1"

  depends_on = [
    ibm_is_vpc_address_prefix.wireguard
  ]
}

data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-20-04-3-minimal-amd64-2"
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
