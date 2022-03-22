resource "metal_device" "wireguard" {
  hostname            = "wireguard.${terraform.workspace}"
  plan                = "c3.small.x86"
  metro               = var.region
  operating_system    = "ubuntu_20_04"
  billing_cycle       = "hourly"
  project_id          = metal_project.wireguard.id
  project_ssh_key_ids = [metal_project_ssh_key.wireguard.id]
  user_data           = data.cloudinit_config.wireguard.rendered
}

resource "metal_project" "wireguard" {
  name = "wireguard-${terraform.workspace}"
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
