variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = number
  description = "The wireguard server's desired data center ID. Use the hostinger_vps_data_centers data source to list available data centers."
}

variable "plan" {
  type        = string
  description = "The VPS plan to use. Use the hostinger_vps_plans data source to list available plans."
  default     = "hostingercom-vps-kvm2-usd-1m"
}

variable "hostname" {
  type        = string
  description = "The FQDN hostname for the wireguard server."
  default     = "wireguard.example.com"
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2"
  }
}
