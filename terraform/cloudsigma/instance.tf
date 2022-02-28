resource "cloudsigma_server" "ubuntu" {
  cpu          = 2000
  memory       = 2048 * 1024 * 1024
  name         = "wireguard-${terraform.workspace}"
  vnc_password = "wireguard"
  ssh_keys     = [cloudsigma_ssh_key.wireguard.id]

  network {
    type = "dhcp"
  }

  drive {
    uuid = cloudsigma_drive.ubuntu.id
  }
  connection {
    host        = self.ipv4_address
    type        = "ssh"
    user        = "cloudsigma"
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = local_file.wireguard.filename
    destination = "/tmp/configure-server.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/configure-server.sh",
      "sudo /tmp/configure-server.sh",
    ]
  }
}

resource "local_file" "wireguard" {
  content  = <<EOF
#!/bin/bash
apt-get -y install wireguard

${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
EOF
  filename = "${path.module}/configure-server.sh"
}

resource "cloudsigma_drive" "ubuntu" {
  name           = "wireguard-${terraform.workspace}"
  media          = "disk"
  clone_drive_id = data.cloudsigma_library_drive.ubuntu.id
  size           = 20 * 1024 * 1024 * 1024
}

data "cloudsigma_library_drive" "ubuntu" {
  filter {
    name   = "name"
    values = ["Ubuntu 20.04 LTS"]
  }
}
