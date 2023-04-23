resource "linode_instance" "wireguard" {
  label           = "wireguard-${terraform.workspace}"
  image           = "linode/ubuntu22.04"
  region          = var.region
  type            = "g6-standard-1"
  authorized_keys = [linode_sshkey.wireguard.ssh_key]
  root_pass       = random_string.root_pass.id
  stackscript_id  = linode_stackscript.wireguard.id
}

resource "random_string" "root_pass" {
  length = 16
}

resource "linode_firewall" "wireguard" {
  label           = "wireguard-${terraform.workspace}"
  linodes         = [linode_instance.wireguard.id]
  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = [local.myip]
  }

  inbound {
    label    = "allow-wg"
    action   = "ACCEPT"
    protocol = "UDP"
    ports    = "51820"
    ipv4     = ["0.0.0.0/0"]
  }
}

resource "linode_stackscript" "wireguard" {
  label       = "wireguard-${terraform.workspace}"
  description = "Installs and configures wireguard."
  images      = ["linode/ubuntu18.04", "linode/ubuntu20.04"]
  rev_note    = "initial version"
  script      = <<EOF
#!/bin/bash
apt-get -y update && apt-get -y install wireguard

${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
EOF
}
