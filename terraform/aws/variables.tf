variable "server_private_key" {
  type        = string
  description = "The private key that will be used for the wireguard server. Can be generated with `wg genkey`."
}

variable "client_public_key" {
  type        = string
  description = "The public key of your wireguard client. Can be derived from the private key with `wg pubkey`."
}

variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions."
}
