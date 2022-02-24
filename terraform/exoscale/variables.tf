variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. .Valid regions at https://www.exoscale.com/datacenters/"
}

variable "api_key" {
  type        = string
  description = "Cloudstack access key."
}

variable "secret_key" {
  type        = string
  description = "Cloudstack secret key."
}
