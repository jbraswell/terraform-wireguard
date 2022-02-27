variable "ssh_key_path" {
  type        = string
  description = "The SSH key path, ex. /home/user/.ssh/id_rsa.pub."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://cloud.ionos.com/data-centers."
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2",
  }
}

variable "username" {
  type        = string
  description = "Ionos username."
}

variable "password" {
  type        = string
  description = "Ionos password."
}
