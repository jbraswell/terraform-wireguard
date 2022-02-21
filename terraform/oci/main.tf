provider "oci" {
  region              = var.region
  config_file_profile = var.config_file_profile
}

provider "wireguard" {}

terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "~> 4.64.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
