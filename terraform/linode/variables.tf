variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://www.linode.com/docs/api/regions/#regions-list."
}

variable "linode_token" {
  type        = string
  description = "Linode authentication token."
}
