resource "upcloud_server" "wireguard" {
  hostname = "terraform.wireguard.tld"
  zone     = var.region
  plan     = "1xCPU-1GB"
  firewall = true

  template {
    storage = "Ubuntu Server 20.04 LTS (Focal Fossa)"
    size    = 25
  }

  network_interface {
    type = "public"
  }

  login {
    user = "wireguard"
    keys = [var.ssh_public_key]
  }
  user_data = <<EOF
#!/bin/bash
apt-get -y update && apt-get -y install wireguard

${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
EOF
}


resource "upcloud_firewall_rules" "wireguard" {
  server_id = upcloud_server.wireguard.id

  firewall_rule {
    action                 = "accept"
    comment                = "Allow SSH"
    destination_port_end   = "22"
    destination_port_start = "22"
    direction              = "in"
    family                 = "IPv4"
    protocol               = "tcp"
    source_address_end     = local.myip
    source_address_start   = local.myip
  }

  firewall_rule {
    action                 = "accept"
    comment                = "Allow Wireguard"
    destination_port_end   = "51820"
    destination_port_start = "51820"
    direction              = "in"
    family                 = "IPv4"
    protocol               = "udp"
    source_address_end     = "0.0.0.0"
    source_address_start   = "0.0.0.0"
  }
}
