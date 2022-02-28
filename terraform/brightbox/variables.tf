variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid values are gb1-a, gb1-b."
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2"
  }
}

variable "username" {
  type        = string
  description = "Brightbox username."
}

variable "password" {
  type        = string
  description = "Brightbox password."
}

variable "account_id" {
  type        = string
  description = "Brightbox account id."
}
