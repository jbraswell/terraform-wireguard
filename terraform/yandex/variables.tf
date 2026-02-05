variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://yandex.cloud/en/docs/overview/concepts/region."
  default     = "ru-central1"
}

variable "zone" {
  type        = string
  description = "The wireguard server's desired availability zone. Valid zones at https://yandex.cloud/en/docs/overview/concepts/geo-scope."
  default     = "ru-central1-d"
}

variable "clients" {
  type        = map(string)
  description = "Map of client names to ip addresses. Must be in the 10.10.10/24 subnet, and 10.10.10.1 is reserved for the server."
  default = {
    "default" = "10.10.10.2"
  }
}
