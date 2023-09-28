variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://contabo.com/en/locations/, to get region ids use their cli and run `cntb get datacenters``."
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2"
  }
}

variable "oauth2_client_id" {
  type        = string
  description = "Your API client ID."
}

variable "oauth2_client_secret" {
  type        = string
  description = "Your API client secret."
}

variable "oauth2_user" {
  type        = string
  description = "Your account username [email].."
}

variable "oauth2_pass" {
  type        = string
  description = "Your account users password."
}
