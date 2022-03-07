resource "kamatera_server" "wireguard" {
  name           = "wireguard-${terraform.workspace}"
  datacenter_id  = var.region
  cpu_type       = "B"
  cpu_cores      = 1
  ram_mb         = 1024
  disk_sizes_gb  = [20]
  image_id       = data.kamatera_image.ubuntu.id
  startup_script = <<EOF
#!/bin/bash
apt-get -y install wireguard
${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
EOF
}

data "kamatera_image" "ubuntu" {
  datacenter_id = var.region
  os            = "Ubuntu"
  code          = "20.04 64bit_optimized_updated"
}
