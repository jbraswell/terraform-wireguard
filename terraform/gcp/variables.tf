variable "ssh_public_key" {
  type        = string
  description = "The SSH key used to access the wireguard server."
}

variable "region" {
  type        = string
  description = "The wireguard server's desired region. Valid regions at https://cloud.google.com/compute/docs/regions-zones."
}

variable "gcp_auth_file" {
  type        = string
  description = "Path to GCP authentication file."
}

variable "gcp_project" {
  type        = string
  description = "GCP project id."
}
