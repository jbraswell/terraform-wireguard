variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "private_key_path" {
  type        = string
  description = "The path to your private key for remote-exec."
  default     = "~/.ssh/id_rsa"
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions are Moscow (ds1), Amsterdam (am2), Almaty (kz), New Jersey (nj3)."
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2",
  }
}

variable "api_key" {
  type        = string
  description = "Serverspace api key."
}
