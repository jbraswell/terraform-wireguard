provider "cloudscale" {
  token = var.cloudscale_token
}

provider "wireguard" {}

terraform {
  required_providers {
    cloudscale = {
      source  = "cloudscale-ch/cloudscale"
      version = "~> 3.2.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
