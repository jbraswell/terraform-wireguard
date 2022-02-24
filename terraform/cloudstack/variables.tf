variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. The cloudstack zone to deploy to."
}

variable "api_url" {
  type        = string
  description = "Cloudstack api url."
}

variable "api_key" {
  type        = string
  description = "Cloudstack access key."
}

variable "secret_key" {
  type        = string
  description = "Cloudstack secret key."
}
