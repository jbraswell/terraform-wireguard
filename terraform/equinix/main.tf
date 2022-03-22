provider "metal" {
  auth_token = var.equinix_auth_token
}

provider "wireguard" {}

terraform {
  required_providers {
    metal = {
      source  = "equinix/metal"
      version = "~> 3.2.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
