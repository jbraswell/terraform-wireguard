resource "serverspace_server" "wireguard" {
  name             = "wireguard-${terraform.workspace}"
  image            = "Ubuntu-20.04-X64"
  location         = var.region
  cpu              = 1
  ram              = 1024
  boot_volume_size = 25 * 1024

  nic {
    network      = ""
    network_type = "PublicShared"
    bandwidth    = 50
  }

  ssh_keys = [
    serverspace_ssh.wireguard.id
  ]

  connection {
    type        = "ssh"
    user        = "root"
    host        = self.public_ip_addresses[0]
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get -y update && apt-get -y install wireguard",
      templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
    ]
  }
}
