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

variable "template" {
  type        = string
  description = "Cloudstack template (image)."
  default     = "Linux Ubuntu 20.04 LTS 64-bit"
}

variable "service_offering" {
  type        = string
  description = "Cloudstack service offering (instance type)."
}
