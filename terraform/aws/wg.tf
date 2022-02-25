resource "wireguard_asymmetric_key" "server" {}

resource "wireguard_asymmetric_key" "client" {
  for_each = var.clients
}

data "wireguard_config_document" "server" {
  private_key = wireguard_asymmetric_key.server.private_key
  listen_port = 51820
  addresses   = ["10.10.10.1/32"]
  post_up = [
    "sysctl -w net.ipv4.ip_forward=1",
    "sysctl -w net.ipv6.conf.all.forwarding=1",
    "iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o $nic -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o $nic -j MASQUERADE",
  ]
  post_down = [
    "iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o $nic -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o $nic -j MASQUERADE",
  ]

  dynamic "peer" {
    for_each = var.clients
    content {
      public_key  = wireguard_asymmetric_key.client[peer.key].public_key
      allowed_ips = ["${peer.value}/32"]
    }
  }
}

data "wireguard_config_document" "client" {
  for_each    = var.clients
  private_key = wireguard_asymmetric_key.client[each.key].private_key
  addresses   = ["${each.value}/32"]
  dns         = ["8.8.8.8"]

  peer {
    endpoint             = "${aws_eip.wireguard.public_ip}:51820"
    public_key           = wireguard_asymmetric_key.server.public_key
    allowed_ips          = ["1.0.0.0/8, 2.0.0.0/8, 3.0.0.0/8, 4.0.0.0/6, 8.0.0.0/7, 11.0.0.0/8, 12.0.0.0/6, 16.0.0.0/4, 32.0.0.0/3, 64.0.0.0/2, 128.0.0.0/3, 160.0.0.0/5, 168.0.0.0/6, 172.0.0.0/12, 172.32.0.0/11, 172.64.0.0/10, 172.128.0.0/9, 173.0.0.0/8, 174.0.0.0/7, 176.0.0.0/4, 192.0.0.0/9, 192.128.0.0/11, 192.160.0.0/13, 192.169.0.0/16, 192.170.0.0/15, 192.172.0.0/14, 192.176.0.0/12, 192.192.0.0/10, 193.0.0.0/8, 194.0.0.0/7, 196.0.0.0/6, 200.0.0.0/5, 208.0.0.0/4"]
    persistent_keepalive = 25
  }
}
