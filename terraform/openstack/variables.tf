variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. The OpenStack zone to deploy to, tested with DreamCompute."
}

variable "auth_url" {
  type        = string
  description = "OpenStack auth url."
}

variable "user_name" {
  type        = string
  description = "OpenStack user name."
}

variable "password" {
  type        = string
  description = "OpenStack password."
}

variable "tenant_name" {
  type        = string
  description = "OpenStack tenant name."
}

variable "tenant_id" {
  type        = string
  description = "OpenStack tenant id."
}
