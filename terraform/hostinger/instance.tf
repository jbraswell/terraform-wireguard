resource "hostinger_vps" "wireguard" {
  plan                   = var.plan
  data_center_id         = var.region
  template_id            = 1012
  hostname               = var.hostname
  ssh_key_ids            = [hostinger_vps_ssh_key.wireguard.id]
  post_install_script_id = hostinger_vps_post_install_script.wireguard.id
}

resource "hostinger_vps_post_install_script" "wireguard" {
  name    = "wireguard-${terraform.workspace}"
  content = <<-EOT
    #!/bin/bash
    apt-get -y update && apt-get -y install wireguard
    ${templatefile("${path.module}/../configure-server.sh.tftpl", { wg0_conf = data.wireguard_config_document.server.conf })}
  EOT
}
