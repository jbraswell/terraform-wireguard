resource "yandex_compute_instance" "wireguard" {
  name        = "wireguard-${terraform.workspace}"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.wireguard.id
    nat                = true
    nat_ip_address     = yandex_vpc_address.wireguard.external_ipv4_address[0].address
    security_group_ids = [yandex_vpc_security_group.wireguard.id]
  }

  metadata = {
    ssh-keys  = "ubuntu:${var.ssh_public_key}"
    user-data = data.cloudinit_config.wireguard.rendered
  }
}

resource "yandex_vpc_network" "wireguard" {
  name = "wireguard-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "wireguard" {
  name           = "wireguard-${terraform.workspace}"
  zone           = var.zone
  network_id     = yandex_vpc_network.wireguard.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_security_group" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  network_id = yandex_vpc_network.wireguard.id

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [local.myip]
  }

  ingress {
    protocol       = "UDP"
    port           = 51820
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_address" "wireguard" {
  name = "wireguard-${terraform.workspace}"

  external_ipv4_address {
    zone_id = var.zone
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
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
