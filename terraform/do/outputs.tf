output "client_config" {
  value = {
    for k, v in data.wireguard_config_document.client : k => v.conf
  }
  description = "Client configuration."
}
