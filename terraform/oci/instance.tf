resource "oci_core_instance" "wireguard" {
  availability_domain = oci_core_subnet.wireguard.availability_domain
  compartment_id      = oci_identity_compartment.wireguard.id
  display_name        = "wireguard-${terraform.workspace}"
  shape               = "VM.Standard2.1"

  create_vnic_details {
    assign_public_ip = false
    display_name     = "eth01"
    hostname_label   = "wireguard"
    subnet_id        = oci_core_subnet.wireguard.id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = data.cloudinit_config.wireguard.rendered
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_focal.images.0.id
  }
}

resource "oci_core_public_ip" "wireguard" {
  compartment_id = oci_identity_compartment.wireguard.id
  display_name   = "wireguard-${terraform.workspace}"
  lifetime       = "RESERVED"
  private_ip_id  = data.oci_core_private_ips.wireguard.private_ips[0]["id"]
}

data "oci_core_vnic_attachments" "wireguard" {
  compartment_id      = oci_identity_compartment.wireguard.id
  availability_domain = data.oci_identity_availability_domains.wireguard.availability_domains[0].name
  instance_id         = oci_core_instance.wireguard.id
}

data "oci_core_vnic" "wireguard" {
  vnic_id = data.oci_core_vnic_attachments.wireguard.vnic_attachments[0]["vnic_id"]
}

data "oci_core_private_ips" "wireguard" {
  vnic_id = data.oci_core_vnic.wireguard.id
}

resource "oci_identity_compartment" "wireguard" {
  compartment_id = var.tenancy_ocid
  description    = "Compartment for Wireguard Terraform resources."
  name           = "wireguard-${terraform.workspace}"
}

data "oci_identity_availability_domains" "wireguard" {
  compartment_id = oci_identity_compartment.wireguard.id
}

resource "oci_core_vcn" "wireguard" {
  dns_label      = "wireguard"
  cidr_block     = var.vpc_cidr_block
  compartment_id = oci_identity_compartment.wireguard.id
  display_name   = "wireguard-${terraform.workspace}"
}

resource "oci_core_internet_gateway" "wireguard" {
  compartment_id = oci_identity_compartment.wireguard.id
  vcn_id         = oci_core_vcn.wireguard.id
  display_name   = "wireguard-${terraform.workspace}"
  enabled        = "true"
}

resource "oci_core_default_route_table" "wireguard" {
  manage_default_resource_id = oci_core_vcn.wireguard.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.wireguard.id
  }
}

resource "oci_core_security_list" "wireguard" {
  compartment_id = oci_identity_compartment.wireguard.id
  vcn_id         = oci_core_vcn.wireguard.id
  display_name   = "wireguard-${terraform.workspace}"
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
  ingress_security_rules {
    protocol = "17"
    source   = "0.0.0.0/0"

    udp_options {
      min = 51820
      max = 51820
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = local.myip

    tcp_options {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_subnet" "wireguard" {
  availability_domain        = data.oci_identity_availability_domains.wireguard.availability_domains[0].name
  cidr_block                 = cidrsubnet(var.vpc_cidr_block, 8, 0)
  display_name               = "wireguard-${terraform.workspace}"
  prohibit_public_ip_on_vnic = false
  dns_label                  = "wireguard"
  compartment_id             = oci_identity_compartment.wireguard.id
  vcn_id                     = oci_core_vcn.wireguard.id
  route_table_id             = oci_core_default_route_table.wireguard.id
  security_list_ids          = [oci_core_security_list.wireguard.id]
  dhcp_options_id            = oci_core_vcn.wireguard.default_dhcp_options_id
}

data "oci_core_images" "ubuntu_focal" {
  compartment_id   = oci_identity_compartment.wireguard.id
  operating_system = "Canonical Ubuntu"
  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-20.04-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "cloudinit_config" "wireguard" {
  gzip          = true
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
