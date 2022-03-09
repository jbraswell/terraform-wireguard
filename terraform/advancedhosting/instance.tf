resource "ah_cloud_server" "wireguard" {
  name       = "wireguard-${terraform.workspace}"
  datacenter = var.region
  image      = data.ah_cloud_images.ubuntu.images[0].slug
  plan       = "start-xs"
  ssh_keys   = [ah_ssh_key.wireguard.id]

  connection {
    type        = "ssh"
    user        = "adminroot"
    host        = self.ips[0].ip_address
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

data "ah_cloud_images" "ubuntu" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  filter {
    key    = "architecture"
    values = ["x86_64"]
  }
  sort {
    key       = "version"
    direction = "desc"
  }
}


