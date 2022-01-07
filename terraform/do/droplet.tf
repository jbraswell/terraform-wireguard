resource "digitalocean_droplet" "wireguard" {
  image     = "ubuntu-20-04-x64"
  name      = "wireguard-${terraform.workspace}"
  region    = "ams3"
  size      = "s-1vcpu-1gb"
  ssh_keys  = [digitalocean_ssh_key.wireguard.fingerprint]
  user_data = data.template_cloudinit_config.wireguard.rendered
}

resource "digitalocean_firewall" "wireguard" {
  name = "wireguard-${terraform.workspace}"

  droplet_ids = [digitalocean_droplet.wireguard.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "51820"
    source_addresses = ["0.0.0.0/0", "::/0"]
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

data "template_cloudinit_config" "wireguard" {
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
    content      = <<TFEOF
#!/bin/bash
privatekey=${var.private_key}

cat << EOF > /etc/wireguard/wg0.conf
[Interface]
Address = 10.10.10.1/32
ListenPort = 51820
PrivateKey = $${privatekey}
PostUp = sysctl -w net.ipv4.ip_forward=1
PostUp = sysctl -w net.ipv6.conf.all.forwarding=1
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = umZP5c0w1GZ3F2Wt/LVbIhKXiVUm9Wot6eSF1HmbREY=
AllowedIPs = 10.10.10.2/32
EOF

chmod 600 /etc/wireguard/wg0.conf
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
TFEOF
  }
}

resource "digitalocean_floating_ip" "wireguard" {
  droplet_id = digitalocean_droplet.wireguard.id
  region     = digitalocean_droplet.wireguard.region
}


