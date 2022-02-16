provider "vultr" {
  api_key = var.vultr_token
}

provider "wireguard" {}

terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.9.1"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
