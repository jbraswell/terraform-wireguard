resource "digitalocean_droplet" "wireguard" {
  image     = "ubuntu-20-04-x64"
  name      = "wireguard-${terraform.workspace}"
  region    = var.region
  size      = "s-1vcpu-1gb"
  ssh_keys  = [digitalocean_ssh_key.wireguard.fingerprint]
  user_data = data.cloudinit_config.wireguard.rendered
}

resource "digitalocean_firewall" "wireguard" {
  name = "wireguard-${terraform.workspace}"

  droplet_ids = [digitalocean_droplet.wireguard.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [local.myip]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "51820"
    source_addresses = [local.myip]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
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

resource "digitalocean_floating_ip" "wireguard" {
  droplet_id = digitalocean_droplet.wireguard.id
  region     = digitalocean_droplet.wireguard.region
}
