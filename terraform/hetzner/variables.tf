variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://www.hetzner.com/unternehmen/rechenzentrum."
}

variable "hcloud_token" {
  type        = string
  description = "Hetzner Cloud authentication token."
}
