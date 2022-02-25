output "client_config" {
  value       = { for k, v in data.wireguard_config_document.client : k => v.conf }
  description = "Client configuration."
}

output "client_config_qr_codes" {
  value       = { for k, v in data.wireguard_config_document.client : k => "https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=${urlencode(v.conf)}" }
  description = "Client configuration qr code links."
}