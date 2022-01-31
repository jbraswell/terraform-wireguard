variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions."
}
