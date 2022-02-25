output "client_config" {
  value       = { for k, v in data.wireguard_config_document.client : k => v.conf }
  description = "Client configuration."
}

output "client_config_qr_codes" {
  value       = { for k, v in data.external.qr : k => v.result.code }
  description = "Client configuration qr code links."
}
