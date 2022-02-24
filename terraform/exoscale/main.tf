provider "exoscale" {
  key    = var.api_key
  secret = var.secret_key
}

provider "wireguard" {}

terraform {
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "~> 0.31.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
