provider "civo" {
  token  = var.civo_token
  region = var.region
}

provider "wireguard" {}

terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "~> 1.0.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.1.3"
    }
  }
}
