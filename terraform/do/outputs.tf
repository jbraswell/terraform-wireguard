output "client_config" {
  value       = data.wireguard_config_document.client.conf
  description = "Client configuration."
}
