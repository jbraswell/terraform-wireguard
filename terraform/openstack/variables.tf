variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. The OpenStack zone to deploy to, tested with DreamCompute."
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2"
  }
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

variable "flavor_name" {
  type        = string
  description = "OpenStack flavor name (instance type)."
}

variable "image_name" {
  type        = string
  description = "OpenStack image name."
  default     = "Ubuntu 20.04"
}
