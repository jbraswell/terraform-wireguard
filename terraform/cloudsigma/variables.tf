variable "private_key_path" {
  type        = string
  description = "The path to your private key for remote-exec."
  default     = "~/.ssh/id_rsa"
}

variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://www.cloudsigma.com/cloud-locations/."
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
  description = "CloudSigma username."
}

variable "password" {
  type        = string
  description = "CloudSigma password."
}
