resource "random_id" "default" {
  byte_length = 8
}

resource "null_resource" "wireguard" {
  triggers = {
    default = random_id.default.hex
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.public_ip
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get -y update && apt-get -y install wireguard",
      templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })
    ]
  }
}
