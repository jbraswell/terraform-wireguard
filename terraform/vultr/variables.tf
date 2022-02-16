variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://api.vultr.com/v2/regions."
}

variable "vultr_token" {
  type        = string
  description = "Vultr authentication token."
}
