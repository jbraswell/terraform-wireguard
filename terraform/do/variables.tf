variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://docs.digitalocean.com/products/platform/availability-matrix/."
}

variable "do_token" {
  type        = string
  description = "DigitalOcean authentication token."
}
