variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/guides/regions_and_zones."
}

variable "project_id" {
  type        = string
  description = "Scaleway project id."
}

variable "access_key" {
  type        = string
  description = "Scaleway access key."
}

variable "secret_key" {
  type        = string
  description = "Scaleway secret key."
}
