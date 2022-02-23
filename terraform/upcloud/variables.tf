variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://upcloud.com/data-centres/."
}

variable "upcloud_username" {
  type        = string
  description = "The username for your upcloud account."
}

variable "upcloud_password" {
  type        = string
  description = "The password for your upcloud account."
}
