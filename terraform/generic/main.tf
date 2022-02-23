provider "wireguard" {}

terraform {
  required_providers {
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
