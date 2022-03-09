variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "private_key_path" {
  type        = string
  description = "The path to your private key for remote-exec."
  default     = "~/.ssh/id_rsa"
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://api.websa.com/api/v1/datacenters."
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2"
  }
}

variable "ah_token" {
  type        = string
  description = "AdvancedHosting authentication token."
}

